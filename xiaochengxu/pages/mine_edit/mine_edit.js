// pages/mine_edit/mine_edit.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    list:[],
    name:"",
    header:"../../image/edit_header.png"
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    
  },

  //退出登录
  logout: function(){
    wx.clearStorageSync();
    wx.switchTab({
      url: '../home/home'
    })
  },

  //头像编辑
  headerClick: function(){
  var that = this

    wx.chooseImage({
        count: 1, // 默认9  
        sizeType: ['compressed'], // 可以指定是原图还是压缩图，默认二者都有  
        sourceType: ['camera'], // 可以指定来源是相册还是相机，默认二者都有  
        success: function (res) {
          // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片  
          var tempFilePaths = res.tempFilePaths[0];

          console.log("==============")

          wx.uploadFile({
            url: getApp().globalData.API_URL + "/Home/Pcenter/pictureUpload",
            filePath: tempFilePaths,
            name: 'user_header',
            header: { "Content-Type": "multipart/form-data" },
            formData: {
              'user_id': wx.getStorageSync(getApp().globalData.USER_ID),
              'access_id': getApp().globalData.ACCESS_ID,
              'device_port': getApp().globalData.DEVICE_PORT,
              'token': wx.getStorageSync(getApp().globalData.TOKEN),
            },
            success: function (res) {

              var value = JSON.parse(res.data);
              console.log(value);
              if (value.status == 1) {
                wx.showToast({
                  title: value.msg,
                })
                console.log(value.data.user_header)
                wx.setStorageSync(getApp().globalData.HEADER, value.data.user_header);
                that.setData({
                  header:tempFilePaths
                })
              }else{

              }
            }
          })
        },
        fail: function (e) {
          wx.showToast({
            title: '取消上传',
            icon: 'none',
            duration: 1000
          })
        },
        complete: function () {
          // wx.hideToast();  //隐藏Toast
        }
    }) 
  },

  cellClick: function (event) {
    if (event.currentTarget.id == 1) {
      wx.navigateTo({
        url: '../nick_name/nick_name',
      })
    } else if (event.currentTarget.id == 2){
      wx.navigateTo({
        url: '../sex/sex',
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
    function model(title, content, show, tag) {
      this.title = title,
        this.content = content,
        this.show = show,
        this.tag = tag
    }
    var tempAry = [];
    tempAry.push(new model("昵称", wx.getStorageSync(getApp().globalData.NICK_NAME), "block", 1));
    var sex = "未设置";
    if (wx.getStorageSync(getApp().globalData.SEX).length > 0) {
      sex = wx.getStorageSync(getApp().globalData.SEX);
    }
    tempAry.push(new model("性别", sex, "block", 2));
    var tel = wx.getStorageSync(getApp().globalData.PHONE);

    var mtel = tel.substr(0, 3) + '****' + tel.substr(7);
    tempAry.push(new model("手机号", mtel, "none", 3));

    var header = "../../image/edit_header.png";
    if (wx.getStorageSync(getApp().globalData.HEADER).length > 0) {
      header = getApp().globalData.API_URL + wx.getStorageSync(getApp().globalData.HEADER)
    }

    console.log(wx.getStorageSync(getApp().globalData.NICK_NAME))
    this.setData({
      list: tempAry,
      name: wx.getStorageSync(getApp().globalData.NICK_NAME),
      header: header
    })
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