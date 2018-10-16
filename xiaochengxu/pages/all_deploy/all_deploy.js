// pages/all_deploy/all_deploy.js
var c_id="";
Page({

  /**
   * 页面的初始数据
   */
  data: {
    deploy_list: [],
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    c_id=options.id;
    function attr(key, value,is_group) {
      this.key = key;
      this.value = value;
      this.is_group = is_group;
    }
    var that = this;
    var network = require("../../utils/network.js")
    //写入参数  
    var params = new Object()
    params.g_id = c_id;
    network.requestLoading(getApp().globalData.API_URL+"/Home/Goods/getConfDetail", params, '正在加载数据', function (res) {
        console.log(res)
        var all_attr=[];
        for(var i=0;i<res.data.length;i++){
          all_attr.push(new attr(res.data[i].group_name, "▣标配 - 无", true));
          for (var j = 0; j < res.data[i].group_list.length; j++) {
            all_attr.push(new attr(res.data[i].group_list[j].attr_name, res.data[i].group_list[j].attr_value, false));
          }
        }
        console.log(all_attr)
        that.setData({
          deploy_list:all_attr,
        })


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