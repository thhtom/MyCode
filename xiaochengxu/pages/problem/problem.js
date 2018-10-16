// pages/problem/problem.js
var dataAry = []

Page({

  /**
   * 页面的初始数据
   */
  data: {
    topList:[],
    contentList:[]
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var that = this;

    var data = {
      "data": [
        {
          "list": [
            {
              "title": "1.   什么是以租代购模式？",
              "content": "以租代购是融资租赁业务的一种形式，它是以客户长租车辆，按逐月支付租金，待租期年限到期后，将车辆所有权过户给客户的形式从而实现客户分期买车。"
            },
            {
              "title": "2.   如鲸平台购车有什么优势",
              "content": "① 0首付，门槛低；\n②资料简便、办理较快捷；\n③代办购置税、保险、报牌等手续，为客户节省大量时间；\n④费用透明，无隐形收费情况。（购置税、新车上牌、过户费等等。）"
            }
          ]
        },
        {
          "list": [
            {
              "title": "1.   提交资料包含哪些",
              "content": "①提供身份证、银行卡、驾驶证；\n②提供营业执照、房产证、在职半年以上单位工作证明；\n③银行流水、在职单位打卡工资流水（半年以上）；\n④配偶身份证、结婚证、银行流水； \n⑤担保人身份证、房产证等\n以上具体资料根据平台官方告知为准。"
            }
          ]
        },
        {
          "list": [
            {
              "title": "1.   以租代购首付比例如何确定？",
              "content": "客户可以在如鲸APP或官网自行选择首付比例；"
            },
            {
              "title": "2.   如何进行分期购车",
              "content": "客户可在线申请24期、36期、48期等，分期以租代购的方式获得车辆所有权；"
            },
            {
              "title": "3.   租赁期间如何进行车辆还款？会提前提醒还款时间和还款金额吗？",
              "content": "①租赁期间还款方式：(具体还款方式暂时还未确定）\n②如鲸购车客服会以短信或电话的形式告知您还款时间及还款金额；"
            },
            {
              "title": "4.   租车期间，是否支持提前还款？",
              "content": "租赁期间，客户（承租人）如需提前还款，终止本合同的，应向如鲸购车平台（出租人）提交书面申请书，经如鲸购车平台（出租人）结算后，向如鲸购车平台（出租人）支付剩余所有租金后，可以提前终止本合同并进行车辆过户。"
            },
            {
              "title": "5.   租赁期满后，保证金是否退还？",
              "content": "租赁期满后，完成车辆过户后进行保证金退还"
            },
            {
              "title": "6.   首次支付的款项中，包含哪些费用？",
              "content": "首次支付的款项包含以下：月供费、车价10％保证金、服务费。"
            }
          ]
        },
        {
          "list": [
            {
              "title": "1.   限购城市的话，汽车上牌都有哪些城市？",
              "content": "如果您在限购城市，如鲸购车可以给您提供临近城市牌照车辆供您使用，具体城市您可咨询在线客服或拨打官方热线。"
            },
            {
              "title": "2.   购车车辆保险是否需要用户自行购置?",
              "content": "在线支付首款成功后，如鲸购车会为您提供一站式服务，车险无需用户自行购置。"
            },
            {
              "title": "3.   购车上牌由谁负责？",
              "content": "如鲸购车会为您完成上牌相关事宜，无需用户自行操作。"
            }
          ]
        },
        {
          "list": [
            {
              "title": "1.   车辆发生事故如何处理和保险理赔？",
              "content": "如客户（承租人）租赁的车辆发生交通事故，必须积极主动配合相关部门进行处理。由此产生的各项费用以及对他人财产损毁产的赔偿费用等，在保险公司依据相关法律、合同进行赔偿后，不足部分，全部由客户（承租人）承担；若出现重大交通事故造成租赁车辆贬值的，客户（承租人）不能退租，租赁车辆贬值的全部损失由客户（承租人）自行承担。"
            },
            {
              "title": "2.   车辆发生违章如何处理？",
              "content": "租赁期间，客户（承租人）使用租赁汽车而产生的违章费用罚款，由客户（承租人）自行承担"
            },
            {
              "title": "3.   租赁期间，车辆是否可以出租、转让或抵押？",
              "content": "租赁期间，未经如鲸购车平台（出租人）书面同意，客户（承租人）不得将租赁车辆设立任何形式的抵押、质押，也不得将租赁车辆出租、转让、馈赠给任何第三人，并保护租赁车辆不受任何侵害。"
            }
          ]
        },
        {
          "list": [
            {
              "title": "1.   车身颜色可以自行选择吗？",
              "content": "目前车身颜色用户可根据官网展示自主选择，以官网现有库存车辆颜色为准。"
            }
          ]
        }
      ]
    }

    dataAry= [];
    for (var i = 0; i < data.data.length; i++) {
      dataAry.push(data.data[i]);
    }

    console.log(dataAry)

    function model(title, tag, background){
      this.title = title;
      this.tag = tag;
      this.background = background;
    }

    var tempAry = [];
    tempAry.push(new model("关于如鲸",0,"rgb(255,228,1)"));
    tempAry.push(new model("资料及审核", 1, "#ffffff"));
    tempAry.push(new model("首付及分期", 2, "#ffffff"));
    tempAry.push(new model("保险及上牌", 3, "#ffffff"));
    tempAry.push(new model("关于售后", 4, "#ffffff"));
    tempAry.push(new model("其他问题", 5, "#ffffff"));

    that.setData({
      topList:tempAry,
      contentList: dataAry[0].list
    });
  },

//按钮点击事件
  btnClick: function (event){
    var that = this;

    function model(title, tag, background) {
      this.title = title;
      this.tag = tag;
      this.background = background;
    }

    var titleAry = ["关于如鲸", "资料及审核", "首付及分期", "保险及上牌", "关于售后","其他问题"];
    var tempAry = [];
    for(var i = 0; i < 6; i++){
      var value = "#ffffff";
      if (i == event.currentTarget.id){
        value = "rgb(255,228,1)";
      }
      tempAry.push(new model(titleAry[i],i ,value))
    }

    var contentAry = dataAry[event.currentTarget.id].list;

    that.setData({
      topList: tempAry,
      contentList: dataAry[event.currentTarget.id].list
    });
},

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
  
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
  
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
  
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  
  }
})