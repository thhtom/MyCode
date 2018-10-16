// pages/counter/counter.js
var is_top = true;
Page({

  /**
   * 页面的初始数据
   */
  data: {
    collect_list: [],
    deploy_list:[],
    url: "",
    rotate:0,
    collect_list_show:"block",
    show: "block"

  },
  top:function(){
    if (is_top){
      is_top = false
      this.setData({
        rotate:180,
        collect_list_show:'none'
      })
    }else{
      is_top = true
      this.setData({
        rotate: 0,
        collect_list_show: "block"
      })

    }
    
  },

  item_click:function(event){
    var detail_path = "../car_detail/car_detail?id=" + event.currentTarget.id;
    wx.navigateTo({
      url: detail_path
    })
  },


  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var that = this;
    var network = require("../../utils/network.js")
    //写入参数  
    var params = new Object()
    params.app_user_id = wx.getStorageSync(getApp().globalData.USER_ID);
    params.page = 1;
    network.requestLoading(getApp().globalData.API_URL + "/Home/Goods/getFavorite", params, '正在加载数据', function (res) {
      console.log(res)
      if (res.status == 1) {

        if(res.data.goods.length>0){

        that.setData({
          collect_list: res.data.goods,
          url: getApp().globalData.WEB_URL,
          deploy_list: res.data.optim,
        })
        }else{
          that.setData({
            show:'none',
            url: getApp().globalData.WEB_URL,
            deploy_list: res.data.optim,
          })

        }



      } else {
        wx.showToast({
          title: res.msg,
          icon: 'fail',
          duration: 2000
        })
      }

    }, function () {
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