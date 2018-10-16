// pages/feedback/feedback.js
var text = "";

Page({

  /**
   * 页面的初始数据
   */
  data: {
  
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    text="";
  },

//获取输入框内容
text: function (e){
  text = e.detail.value;
},

//取消按钮
  cancelClick: function (){
    wx.navigateBack({
      
    })
  },

  //提交按钮
  sureClick: function (){
    if(text.length == 0){
      wx.showToast({
        title: '请输入反馈内容',
        icon:"none",
        duration:1500
      })
    }else{
      var value = " ";
      var network = require("../../utils/network.js")
      var params = new Object()
      params.user_id = wx.getStorageSync(getApp().globalData.USER_ID);
      params.content = text;
      network.requestLoading(getApp().globalData.API_URL + "/Home/Pcenter/addFeedback", params, '正在加载数据', function (res) {

        if (res.status == 1) {
          wx.showToast({
            title: '提交成功',
            icon: "none",
            duration: 2000
          })
          text="";

          setTimeout(function (){
            wx.navigateBack({
              
            })
          },2000)
          
        } else {

        }

      }, function () {
        wx.showToast({
          title: '加载数据失败',
        })
      })
    }
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