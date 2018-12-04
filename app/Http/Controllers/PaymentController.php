<?php
use Illuminate\Support\Facades\DB;
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Paymentsheet;
use App\Product;
use App\Purchase;
use App\Invoice;
use App\Payment;
use App\Selling;
use App\Bonus;
use Auth;
class PaymentController extends Controller
{
    public function getOutstanding($id)
    {
        $outStanding=Paymentsheet::where('uid',$id)
        ->where('paymentFor','supplier')
        ->sum('amount');
        $ledger=Paymentsheet::where('uid',$id)
        ->where('paymentFor','supplier')
        ->get();
        return response()->json([
            'msg' => 'Found',
            'outStanding'=> $outStanding,
            'ledger'=> $ledger,
       ],200);
    }
    public function getOutstandingCustomer($id)
    {
        $outStanding=Paymentsheet::where('uid',$id)
            ->where('paymentFor','customer')
            ->whereIn('type',['due','opening','dueincoming'])
            ->sum('amount');
        $ledger=Paymentsheet::where('uid',$id)
        ->with('customer')
        ->with('admin')
        ->where('paymentFor','customer')
        ->whereIn('type',['due','opening','dueincoming'])
        ->get();
        $bonus=Bonus::where('user_id',$id)
            ->sum('amount');
        return response()->json([
            'msg' => 'Found',
            'outStanding'=> $outStanding,
            'ledger'=> $ledger,
            'bonus'=> $bonus,
       ],200);
    }
    public function getLedgerCustomer($id)
    {
        $outStanding=Paymentsheet::where('uid',$id)
            ->where('paymentFor','customer')
            ->whereIn('type',['due','opening','dueincoming','incoming'])
            ->sum('amount');
        $ledger=Paymentsheet::where('uid',$id)
        ->with('customer')
        ->with('admin')
        ->where('paymentFor','customer')
            ->whereIn('type',['due','opening','dueincoming','incoming'])
            ->get();
        $bonus=Bonus::where('user_id',$id)
            ->sum('amount');
        return response()->json([
            'msg' => 'Found',
            'outStanding'=> $outStanding,
            'ledger'=> $ledger,
            'bonus'=> $bonus,
       ],200);
    }
    public function getLedgerSupplier($id)
    {
        $outStanding=Paymentsheet::where('uid',$id)
            ->where('paymentFor','supplier')
            ->whereIn('type',['due','opening','outgoing'])
            ->sum('amount');
        $ledger=Paymentsheet::where('uid',$id)
        ->with('supplier')
        ->with('admin')
        ->where('paymentFor','supplier')
            ->whereIn('type',['due','opening','outgoing'])
            ->get();
        $bonus=Bonus::where('user_id',$id)
            ->sum('amount');
        return response()->json([
            'msg' => 'Found',
            'outStanding'=> $outStanding,
            'ledger'=> $ledger,
            'bonus'=> $bonus,
       ],200);
    }
    
    public function paymentSupplier(Request $request)
    {
        $admin_id=Auth::user()->id;
        $input=$request->all();
        // create invoice 
        $invoice=Payment::create([
            'admin_id' => $admin_id,
            'uid' => $input['supplier_id'],
            'type' => 'outgoing',
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],
        ]);
        $paymentSheet=Paymentsheet::create([
            'admin_id' => $admin_id,
            'invoice_id' => 0,// 0 if its payment or voucher
            'payment_id' => $invoice->id,
            'type' => 'outgoing',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
            'paymentFor'=> 'supplier',//  customer mean, I am selling to customer, supllier mean buying from suplier 
            'uid' => $input['supplier_id'],
            'amount' => $input['paidAmount']* -1,
            'paymentMethod' => 'cash',
            'date' => $input['date'],
            'remarks' => 'Pay to Supplier',
        ]);

        $data=Paymentsheet::where('id',$paymentSheet->id)
        ->first();        
         return response()->json([
                 'msg' => 'Inserted',
                 'data'=> $data,
            ],200);
    }
    public function paymentCustomer(Request $request)
    {
        $admin_id=Auth::user()->id;
        $input=$request->all();
        // create invoice 
        $invoice=Payment::create([
            'admin_id' => $admin_id,
            'uid' => $input['customer_id'],
            'type' => 'incoming',
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],
        ]);
        $paymentSheet=Paymentsheet::create([
            'admin_id' => $admin_id,
            'invoice_id' => 0,// 0 if its payment or voucher
            'payment_id' => $invoice->id,
            'type' => 'dueIncoming',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
            'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
            'uid' => $input['customer_id'],
            'amount' => $input['paidAmount'],
            'paymentMethod' => 'cash',
            'date' => $input['date'],
            'remarks' => 'Paid by Customer',
        ]);

        $data=Payment::where('id',$invoice->id)
        ->first();        
         return response()->json([
                 'msg' => 'Inserted',
                 'data'=> $data,
            ],200);
    }
    function paymentList($from,$to)
    {
        $data=Payment::where('type','outgoing')
        ->with('admin')
        ->with('supplier')
        ->whereBetween('date', array($from, $to))        
        ->get();
        return $data;
        
    }
    function collectionList($from,$to)
    {
        $data=Payment::where('type','incoming')
        ->with('admin')
        ->with('customer')
        ->whereBetween('date', array($from, $to))
        ->get();
        return $data;
        
    }
    function paymentCancel($id)
    {
        $payment = Payment::where('id','=',$id)
            ->delete();
        $paymentsheet = Paymentsheet::where('payment_id','=',$id)
            ->delete();
        return response()->json(['msg'=>'success','status'=>$id]);

        
    }
    function collectionCancel($id)
    {
        $payment = Payment::where('id','=',$id)
        ->delete();
        $paymentsheet = Paymentsheet::where('payment_id','=',$id)
            ->delete();
        
            return response()->json(['msg'=>'success','status'=>$id]);
       
        
    }
}
