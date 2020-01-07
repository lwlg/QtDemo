import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0
import "qrc:/MaterialUI/"
import "qrc:/MaterialUI/Interface/"

import MainHelper 1.0


Window {
    visible: true
    id:applicationWindow
    x:0
    y:0
    width: 800
    height: 600
    color: "#ffffff"
    opacity: 100
    title: "主显示"

//    flags:(Qt.Window | Qt.FramelessWindowHint)


    MainHelperQml{
        id:mainHelper_C;
    }

    property var loginForm; // 登录界面
    property var selfCheckForm; // 自检界面
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //加载登录界面
    function loadLoginUI(){
        var itemQrcLocation = "qrc:/MainUI/unpayAreaUpdate.qml";
        var component = Qt.createComponent(itemQrcLocation);
        if(Component.Ready=== component.status)
        {
            loginForm = component.createObject(applicationWindow);
            console.log("page created");
//            applicationWindow.visible = false;
        }
    }

    //加载硬件自检
    function loadSelfCheck(){
        var itemQrcLocation = "qrc:/MainUI/selfCheck.qml";
        var component = Qt.createComponent(itemQrcLocation);
        if(Component.Ready=== component.status)
        {
            selfCheckForm = component.createObject(applicationWindow);
            console.debug("加载自检界面完成.")

            selfCheckForm.test();
        }

    }

    //当前日期时间
    function currentDateTime(){
        return Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss ddd");
    }

    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


    Component.onCompleted: {
//        loadLoginUI();//加载登录界面

        //加载自检界面
        loadSelfCheck();

        dtCurrTimer.start();
        var cc = mainHelper_C.getIsPayAera();
        foot_location.text = cc?"付费区":"非付费区"

    }

    //2 顶部标题栏
    Rectangle {
        x: 0
        z: 0
        width: parent.width
        height: 64
        color: "#003463"

        MaterialLabel {
            id: labelForCurrentItemTitleName
            x: 20
            z: 1
            height: 64
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.Left
            color: "#ffffff"
            text: "自助式客服一体机"
        }
    }

//    XmlListModel {
//        id: xmlModelIsPayAera
//        source: "file:../../bin/menu.xml"
//        query: "/rss/channel/item"
//        XmlRole { name: "isPayArea"; query: "isPayArea/string()" }
//    }


    //主页菜单项
    XmlListModel {
        id: xmlModelPay
        source: "qrc:/cfg/menu.xml"
        query: "/rss/channel1/item"
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "qrc"; query: "qrc/string()" }
    }////PayArea model is end


    XmlListModel {
        id: xmlModelUnPay
        source: "qrc:/cfg/menu.xml"
        query: "/rss/channel2/item"
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "qrc"; query: "qrc/string()" }
    }//unPayArea model is end

    Component{
           id: menuDelegate
           Item{
               id: wrapper
               width: videoView.cellWidth
               height: videoView.cellHeight
               MouseArea{
                   anchors.fill: parent
                   onClicked:{
                       wrapper.GridView.view.currentIndex = index;
                       console.log(index);
                       switch(index)
                       {
                       case 0:

                           if(mainHelper_C.getIsPayAera())
                           {
                               itemForMainPage.showPage(xmlModelPay.get(index).title,xmlModelPay.get(index).qrc);
                               console.log(xmlModelPay.get(index).qrc);
                           }
                           else
                           {
                               itemForMainPage.showPage(xmlModelUnPay.get(index).title,xmlModelUnPay.get(index).qrc);
                               console.log(xmlModelUnPay.get(index).qrc);
                           }
                           mainMenu.visible = false;


                           break;
                       default:mainMenu.visible = true;
                           break;
                       }
                   }
               }

               Text{
                   anchors.centerIn: parent
                   width: parent.width

                   text: title
                   color: wrapper.GridView.isCurrentItem ? "#FFFFFF" : "black"
                   font.pixelSize: 30
                   font.bold: false
                   horizontalAlignment: Text.AlignHCenter
                   elide: Text.ElideMiddle
                   font.family: "微软雅黑"
               }
           }
       }//Menu model is end


    Rectangle{
        id:mainMenu
        anchors.centerIn: parent

        color: "white"
//        border.color: "#cdcdcd"
//        border.width: 2
        radius: 10


        Rectangle{
            anchors.centerIn: parent
            width: parent.width
            height: 2
            color: "#e1e1e1"
        }

        Rectangle{
            anchors.centerIn: parent
            width: 2
            height: parent.height
            color: "#e1e1e1"
        }

        //阴影效果
        RectangularGlow{
            anchors.centerIn: parent
            z:-1
            width: mainMenu.width
            height: mainMenu.height
            glowRadius: 5
            spread: 0.22
            color: "#E1E1E1"
            cornerRadius: 5
        }


        width: 400
        height: 400
        GridView{
               id: videoView
               anchors.fill:  parent

               cellWidth: width/2
               cellHeight: height/2

               delegate: menuDelegate
               model:(mainHelper_C.getIsPayAera()) ? xmlModelPay:xmlModelUnPay
               focus: true
               highlight: Rectangle{
                   color: "#349BFC"
                   radius: 10

               }
           }
    }

    //4--底部状态栏
    Rectangle{
        id:footer
        anchors.bottom: parent.bottom

        width: parent.width
        height: 42
        color: "#003463"
        RowLayout{
           spacing: 20
           width: parent.width
           anchors.left:  parent.left
           anchors.right: parent.right
           MaterialLabel {
               id: foot_stationName
               x: 20
               z: 1
               height: 42
               font.pixelSize: 20
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter
               color: "#ffffff"
               text: "星空路"
           }

           MaterialLabel {
               id: foot_softver
               x: 20
               z: 1
               height: 42
               font.pixelSize: 20
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter
               color: "#ffffff"
               text: "19110801"
           }

           MaterialLabel {
               id: foot_userID
               x: 20
               z: 1
               height: 42
               font.pixelSize: 20
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter
               color: "#ffffff"
               text: ""
           }

           MaterialLabel {
               id: foot_userName
               x: 20
               z: 1
               height: 42
               font.pixelSize: 20
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter
               color: "#ffffff"
               text: ""
           }

           MaterialLabel {
               id: foot_netStatus
               x: 20
               z: 1
               height: 42
               font.pixelSize: 20
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter
               color: "#00ff00"
               text: "联网"
           }

           MaterialLabel {
               id: foot_runMode
               x: 20
               z: 1
               height: 42
               font.pixelSize: 20
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter
               color: "#ffffff"
               text: "正常模式"
           }

           MaterialLabel {
               id: foot_location
               x: 20
               z: 1
               height: 42
               font.pixelSize: 20
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter
               color: "#ffffff"
               text: ""
           }

           MaterialLabel {
               id: foot_time
               x: 20
               z: 1
               height: 42
               font.pixelSize: 20
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignHCenter
               color: "#ffffff"
               text: ""

               anchors.right: parent.right
           }

        }
    }
    //!4--底部状态栏

    ///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //--显示区域界面跳转
    Item {
        id: itemForMainPage
        x:0
        y:64
        z:-2
        width: parent.width
        height: parent.height-64

        property var pages: new Object

        function showPage(titleName,itemQrcLocation)
        {
            showPageTimer.titleName = titleName;
            showPageTimer.itemQrcLocation = itemQrcLocation;
            console.log("->",titleName,itemQrcLocation);
            showPageTimer.start();
        }


        Timer{
            id: showPageTimer
            interval: 5
            repeat: false
            running: false
            property string titleName
            property string itemQrcLocation

            onTriggered: {
//                labelForCurrentItemTitleName.text = titleName;
                switch(itemQrcLocation)
                {
                case "":break;
                default:
                    if(!(itemQrcLocation in itemForMainPage.pages))
                    {
                        var component = Qt.createComponent(itemQrcLocation);
                        if(Component.Ready=== component.status)
                        {
                            var page = component.createObject(itemForMainPage);
                            page.anchors.fill = itemForMainPage;
                            console.log(">>>>>)))");
                            console.log(">>>>>"+titleName);

                            itemForMainPage.pages[itemQrcLocation]= page;
                            console.log("page created");
                        }
                    }

                    for(var key in itemForMainPage.pages)
                    {
                        itemForMainPage.pages[key].visible = false;
                    }


                    itemForMainPage.pages[itemQrcLocation].visible = true;
                    console.log("-->"+ itemQrcLocation);
                    break;
                }
            }//onTriggered
        }//Timer
    }//Item
    //!--显示区域界面跳转

    //定时器
    Timer{
        id: dtCurrTimer
        interval: 1 //间隔(单位毫秒):1000毫秒=1秒
        repeat: true //重复
        onTriggered:{
            foot_time.text = currentDateTime();
        }
    }

}
















