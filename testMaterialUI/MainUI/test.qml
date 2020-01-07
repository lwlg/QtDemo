import QtQuick 2.0
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4

import "qrc:/MaterialUI/"
import "qrc:/MaterialUI/Interface/"


Rectangle {
    id:root
    width:300;height:400
    color: "#ffffff"

    MaterialUI {
        id: materialUI
        z: 2
        anchors.fill: parent
        dialogCancelText: "取消"
        dialogOKText: "确定"
    }

//    Button {
//        x:20
//        y:20
//        text: "A button"
//        style: ButtonStyle {
//            background: Rectangle {
//                implicitWidth: 100
//                implicitHeight: 25
//                border.width:  2
//                border.color: "#349BFC"
//                radius: 4

//            }
//        }
//    }

//    Rectangle{
//        x:20
//        y:20
//        width: 100
//        height: 50
//        border.color: "#349BFC"
//        border.width: 2

    Row{
        spacing: 20

        MaterialButton{
            id:testdd
            text: "testdd"
            checkable: true
            onClicked: {
                console.log("clicked");
            }
      }

        Button{
            id:ccc
            text: "button"
            checkable: true
        }




    }




//    }




    MaterialLabel{
        id:updateTitle
        text: "查询结果"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: recContext.top
        anchors.bottomMargin: 15
        font.pixelSize: 38
    }

    Rectangle{
        id:recContext
        width: 500
        height: 300
        anchors.top:parent.top
        anchors.topMargin: 90

        anchors.horizontalCenter: parent.horizontalCenter
        color: "#349BFC"
        border.color: "#D8D8D8"
        border.width: 3
        radius: 10

        //阴影效果
        RectangularGlow{
            anchors.centerIn: parent
            z:-1
            width: parent.width
            height: parent.height
            glowRadius: 5
            spread: 0.22
            color: "#D8D8D8"
            cornerRadius: 5
        }

        //主要内容
        Grid{
            id:updateContext
            anchors.centerIn: parent
            rows: 7;
            columns: 2;
            rowSpacing: 10;
            columnSpacing: 30;
            flow: Grid.TopToBottom;

            add:Transition {
                NumberAnimation{ properties: "x"; duration: 500 }
            }

            move: Transition {
                NumberAnimation{ properties: "x"; duration: 500 }
            }

            Component.onCompleted:{

            }

            MaterialLabel{
                font.pixelSize: 20
                color: "#ffffff"
                text: "车票类型:"
            }
            MaterialLabel{
                font.pixelSize: 20
                color: "#ffffff"
                text: "旅程状态:"
            }
            MaterialLabel{
                font.pixelSize: 20
                color: "#ffffff"
                text: "进站车站:"
            }
            MaterialLabel{
                font.pixelSize: 20
                color: "#ffffff"
                text: "使用时间:"
            }
            MaterialLabel{
                font.pixelSize: 20
                color: "#ffffff"
                text: "票卡余额:"
            }
            MaterialLabel{
                font.pixelSize: 20
                color: "#ffffff"
                text: "更新方式:"
            }
            MaterialLabel{
                font.pixelSize: 20
                color: "#ffffff"
                text: "更新金额:"
            }

            ///寻到卡内容
            MaterialLabel{
                id:lbl_ticketType
                font.pixelSize: 20
                color: "#ffffff"
                text: "单程票"
            }
            MaterialLabel{
                id:lbl_tickeStatus
                font.pixelSize: 20
                color: "#ffffff";
                text: "已进站"
            }
            MaterialLabel{
                id:lbl_InStation
                font.pixelSize: 20
                color: "#ffffff"
                text: "奥体中心站"
            }
            MaterialLabel{
                id:lbl_usedTime
                font.pixelSize: 20
                color: "#ffffff"
                text: "2019-11-14 11:00:00"
            }
            MaterialLabel{
                id:lbl_balance
                font.pixelSize: 20
                color: "#ffffff"
                text: "112.04"
            }

            MaterialLabel{
                id:lbl_updateReason
                font.pixelSize: 20
                color: "#ffffff"
                text: "滞留超时处理"
            }

            MaterialLabel{
                id:lbl_updateMoney
                font.pixelSize: 20
                color: "#ffffff"
                text: "9.00"
            }
        }

    }

    Row{
        anchors.top:recContext.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter:  parent.horizontalCenter

        spacing: 150

        MaterialButton{
            id:btn_returnHome;

            width: 120
            height: 42
            text: "返回"
//            checkable: true
//            checked: true

            onClicked: {
                root.visible = false;
                mainMenu.visible = true;
            }
        }

        MaterialButton{
            id:btn_confirm;

            width: 120
            height: 42
            text: "确定"
//            checkable: true
//            checked: true

            onClicked: {
                confirm.show("提示","是否确认处理?","瞻仰",cardcancle)


            }
        }

    }

    MaterialDialogAlert{
        id:confirm
    }

function cardcancle(){

}

function cardconfirm(){

}


//    MaterialCheckBox{
//        id:checkboo
//        x:100
//        y:50
//        text: "显示站点"
//        checked: true
//        onCheckedChanged: {
//            fegrid.visible = checkedState;
//        }
//    }


//    Grid
//    {
//        id:fegrid
//        anchors.centerIn: parent
//        rows: 3;
//        columns: 3;
//        rowSpacing: 4;
//        columnSpacing: 4;
//        flow: Grid.LeftToRight ;

//        add:Transition {
//            NumberAnimation{ properties: "x"; duration: 500 }
//        }

//        move: Transition {
//            NumberAnimation{ properties: "x"; duration: 500 }
//        }


//        Component.onCompleted:{
//              //ListPair_SS lspss
//              function clickedBtn(idStation)
//              {
//                  console.log("station id:" + idStation);
//              }

//              //创建组件
//              var component = Qt.createComponent("qrc:/MaterialUI/Interface/MaterialButton.qml")
//              for(var i = 0;i < 9;++i)
//              {
//                  //创建对象
//                  var sprite = component.createObject(fegrid,{text:"动态MyButton" + i,idPropertyText:i})
//                  //链接信号和槽
//                  sprite.onIdPropertyclicked.connect(clickedBtn);
//              }
//          }
//    }
}
