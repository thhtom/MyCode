// pages/mine/mine.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    list1:[],
    list2:[],
    name:"",
    header:""
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

    wx.login({
      success: function () {
        wx.getUserInfo({
          success: function (res) {
            var simpleUser = res.userInfo;
            console.log(simpleUser.nickName);
          }
        });
      }
    });

    var that =this;
    function mine(icon,title,tag){
      this.icon = icon, 
      this.title = title, 
      this.tag = tag};
    var temp1 = [];
    var temp2 = [];
    
    // temp1.push(new mine("../../image/mine_record.png", "浏览记录", 1));
    temp1.push(new mine("../../image/mine_collection.png", "我的收藏", 1));
    temp1.push(new mine("../../image/mine_appointment.png", "我的预约", 2));
    temp1.push(new mine("../../image/mine_order.png", "我的订单", 3));
    temp1.push(new mine("../../image/mine_paperwork.png", "我的证件", 4));

    temp2.push(new mine("../../image/mine_aboutus.png", "关于我们", 1));
    temp2.push(new mine("../../image/mine_feedback.png", "意见反馈", 2));

    var header = "../../image/mine_header.png";
    if (wx.getStorageSync(getApp().globalData.HEADER).length > 0) {
      header = getApp().globalData.WEB_URL + wx.getStorageSync(getApp().globalData.HEADER)
    }

    console.log(header)

    var name = "";
    if (wx.getStorageSync(getApp().globalData.NICK_NAME).length > 0) {
      name = wx.getStorageSync(getApp().globalData.NICK_NAME)
    }

    that.setData({
      list1:temp1,
      list2:temp2,
      name:name,
      header: header
    });
  },
//设置点击事件
  settingClcik: function () {
    wx.showToast({
      title: '设置',
    })
  },

  //编辑点击事件
  editClick: function () {
    var value = "../login/login";
    if(wx.getStorageSync(getApp().globalData.USER_ID).length > 0){
      value = '../mine_edit/mine_edit';
    }
    wx.navigateTo({
      url: value,
    })
  },

  //cell点击事件
  itemClick: function (event) {
    if (wx.getStorageSync(getApp().globalData.USER_ID).length > 0){
      if (event.currentTarget.id == 2) {
        wx.navigateTo({
          url: '../my_reserve/my_reserve',
        })
      }else if(event.currentTarget.id == 1){
        wx.navigateTo({
          url: '../my_collection/my_collection',
        })
      } else if (event.currentTarget.id == 3) {
        wx.navigateTo({
          url: '../order_list/order_list',
        })
      } else if(event.currentTarget.id == 4){
        wx.navigateTo({
          url: '../credentials/credentials',
        })
      }
    }else{
      wx.navigateTo({
        url: '../login/login',
      })
    }
  },

  item2Click: function (event){
      if(wx.getStorageInfoSync(getApp().globalData.USER_ID.length > 0)){
        if(event.currentTarget.id == 1){
          wx.navigateTo({
            url: '../web/web?url=https://www.rujcar.com/appUse.html',
          })
        } else if (event.currentTarget.id == 2){
          var value = "../login/login";
          if (wx.getStorageSync(getApp().globalData.USER_ID).length > 0){
            value = '../feedback/feedback'
          }
          wx.navigateTo({
            url: value,
          })
        }
      }else{
        wx.navigateTo({
          url: '../login.login',
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
    var header = "../../image/mine_header.png";
    if (wx.getStorageSync(getApp().globalData.HEADER).length > 0) {
      header = getApp().globalData.API_URL + wx.getStorageSync(getApp().globalData.HEADER)
    }

    var name = "";
    if (wx.getStorageSync(getApp().globalData.NICK_NAME).length > 0) {
      name = wx.getStorageSync(getApp().globalData.NICK_NAME)
    }

    this.setData({
      name: name,
      header: header
    });
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