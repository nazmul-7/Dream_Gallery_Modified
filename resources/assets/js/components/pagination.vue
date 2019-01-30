<template>
  <div>
    <ul>
      <li v-for="(p,i) in paginatedData" :key="i">
        {{p.first}}
        {{p.last}}
        {{p.suffix}}
      </li>
    </ul>
    <button :disabled="pageNumber==0" @click="prevPage">Previous</button>
    <button :disabled="pageNumber >= (pagecount() -1)" @click="nextPage">Next</button>
  </div>
</template>

<script>
export default {
  props: {
    listData: {
      type: Array,
      required: true
    },
    size: {
      type: Number,
      required: false,
      default: 10
    }
  },
  data() {
    return {
      pageNumber: 0 // default to page 0
    };
  },
  methods: {
    nextPage() {
      this.pageNumber++;
    },
    prevPage() {
      this.pageNumber--;
    }
  },
   computed:{
    pageCount(){
      let l = this.listData.length,
          s = this.size;
      return Math.floor(l/s);
    },
    paginatedData(){
      const start = this.pageNumber * this.size,
            end = start + this.size;
      return this.listData
               .slice(start, end);
    }
  },
};
</script>
<style scoped>
ul{
  padding: 4px 4px;
  border: 1px solid black;
  
}
li{
  list-style-type:none;
  padding:4px 4px;
}
li:hover{
  background-color:#eee;
}
li:nth-child(2n){
  background-color:#ddd;
}
li:nth-child(2n):hover{
  background-color:#ccc;
}

button{
  width:100px;
  height:40px;
  background-color:#eef;
}

button:hover{
  cursor:pointer;
}
button:hover:disabled{
  cursor:not-allowed;
}
</style>


