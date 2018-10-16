function request(url, params, success, fail) {
  this.requestLoading(url, params, "", success, fail)
}
// 展示进度条的网络请求
// url:网络请求的url
// params:请求参数
// message:进度条的提示信息
// success:成功的回调函数
// fail：失败的回调
function requestLoading(url, params, message, success, fail) {
  var params = params
  params.access_id = getApp().globalData.ACCESS_ID,

  params.device_port = getApp().globalData.DEVICE_PORT,
  params.token = wx.getStorageSync(getApp().globalData.TOKEN),

  wx.showNavigationBarLoading()
  if (message != "") {
    wx.showLoading({
      title: message,
    })
  }
  wx.request({
    url: url,
    data: params,
    header: {
      // 'Content-Type': 'application/json'
      'content-type': 'application/x-www-form-urlencoded'
    },
    method: 'post',
    success: function (res) {
      console.log(res)



      wx.hideNavigationBarLoading()
      if (res.data.status == 401) {
        wx.hideLoading()
        wx.showToast({
          title: '登陆失效，请重新登陆！',
          icon:'none'
        })
        wx.navigateTo({
          url: "../login/login"
        })
      } else {
        if (message != "") {
          wx.hideLoading()
        }
        if (res.statusCode == 200) {
          success(res.data)
        } else {
          fail()
        }
      }

    },
    fail: function (res) {
      wx.hideNavigationBarLoading()
      if (message != "") {
        wx.hideLoading()
      }
      fail()
    },
    complete: function (res) {

    },
  })
}
module.exports = {
  request: request,
  requestLoading: requestLoading
}