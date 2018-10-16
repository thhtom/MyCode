// pages/order_detail/order_detail.js
var is_show= true;
Page({
  /**
   * 页面的初始数据
   */
  data: {
    show: "block",
    rotate:0,
    user_name:"",
    // id_card:"",
    mobile:"",
    order_id:"",
    order_time:"",
    car_img:"",
    title:"",
    all_cost:"",
    fir_money:"",
    month_money:"",
    deposit:"",
    service:"",
    portion:"",
    overall:"",
  },

  show_money:function(){
    if(is_show){
      is_show = false
      this.setData({
        show: "none",
        rotate:180,
      })
    }else{
      is_show = true
      this.setData({
        show: "block",
        rotate:0,
      })
    }

  },


  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var that = this;
    var network = require("../../utils/network.js")
    //写入参数  
    var params = new Object()
    params.user_id = wx.getStorageSync(getApp().globalData.USER_ID);
    params.order_id = options.id;
    network.requestLoading(getApp().globalData.API_URL + "/Home/Orders/ordersDetails", params, '正在加载数据', function (res) {
      console.log(res)
      var img_url = getApp().globalData.WEB_URL + res.data.pic_url;
      console.log(img_url)
      if (res.status = 1) {
        that.setData({
          user_name: res.data.user_name,
          // id_card: res.data.id_card,
          mobile: res.data.mobile,
          order_id: "NO." + res.data.order_sn_id,
          order_time: res.data.pay_time,
          car_img: img_url,
          title: res.data.title,
          all_cost: "¥" +res.data.price.first_car_lift_cost,
          fir_money: "¥" + res.data.price.vehicle_shoufu,
          month_money: "¥" + res.data.price.monthly_mortgage_payment,
          deposit: "¥" + res.data.price.bond,
          service: "¥" + res.data.price.service_fees,
          portion: "已还" + res.data.paid_pmts,
          overall: res.data.tot_pmts+"期",
        })
        
      } else {
        wx.showToast({
          title: res.msg,
        })
      }
    }, function () {
      wx.hideNavigationBarLoading()
      wx.stopPullDownRefresh()
      wx.showToast({
        title: '加载数据失败',
      })
    })




  
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