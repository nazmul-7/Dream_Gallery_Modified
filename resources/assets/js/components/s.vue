<template>
   <div>
       <Row>
            <Col class="dream-input-main" span="12" offset="1">
                    <Card>
                        <p slot="title">
                            <Icon type="pinpoint"></Icon>
                            fgfgf cgfhghfg
                        </p>
                        <Row>
                            <Input v-model="searchConName1" icon="search" 
                            @on-change="handleSearch1" placeholder="请输入姓名搜索..." style="width: 200px" />
                        </Row>
                        <Row class="margin-top-10 searchable-table-con1">
                            <Table :columns="columns1" :data="data1"></Table>
                        </Row>
                    </Card>
            </Col>
        </Row>
   </div>
</template>
<script>
    export default {
        data () {
            return {
                isCollapsed: false,
                searchConName1: '',
                columns1: [
                    {
                        title: 'Name',
                        key: 'name'
                    },
                    {
                        title: 'Age',
                        key: 'age'
                    },
                ],
                data1: [
                    {
                        name: 'John Brown',
                        age: 'my Name is njhasdfnkj jgbf jgsidh'
                    },
                    {
                        name: 'Jim Green',
                        age: 'Text',
                    },
                    {
                        name: 'Joe Black',
                        age: 30,
                    },
                    {
                        name: 'Jon Snow',
                        age: 26,
                    }
                ]
            }
        },
        computed: {
            rotateIcon () {
                return [
                    'menu-icon',
                    this.isCollapsed ? 'rotate-icon' : ''
                ];
            },
            menuitemClasses () {
                return [
                    'menu-item',
                    this.isCollapsed ? 'collapsed-menu' : ''
                ]
            }
        },
        methods: {
            init () {
                    this.data1 = this.initTable1 = table.searchTable1;
                },
                collapsedSider () {
                    this.$refs.side1.toggleCollapse();
                },
                 handleSearch1 () {
                    this.data1 = this.initTable1;
                    this.data1 = this.search(this.data1, {name: this.searchConName1});
                },
            },
            mounted () {
             this.init();
            }
    }
</script>
