// pages/service/service.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
  
  },

//计算器
 calculator: function () {
   wx.navigateTo({
     url: '../counter/counter'
   })
 },

 //汽车资讯
news: function () {
  wx.navigateTo({
    url: '../car_news/car_news'
  })
},

 //常见问题
 problem: function () {
    wx.navigateTo({
      url: '../problem/problem',
    })
 },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
  
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