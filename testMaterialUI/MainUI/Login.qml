/*
    This file is part of JQTools

    Project introduce: https://github.com/188080501/JQTools

    Copyright: Jason

    Contact email: Jason@JasonServer.com

    GitHub: https://github.com/188080501/
*/

import QtQuick 2.3
import QtQuick 2.5
import QtQuick.Controls 1.4
import "qrc:/MaterialUI/Interface/"
import "qrc:/MaterialUI/"
import LoginForm 1.0


Item {
    id: login
    width: parent.width
    height: parent.height
    opacity: 100

    Image {
        id: backgroundImg
        anchors.fill: parent
        source: "file:../img/backgnd.png"
//        source: "file:./../img/backgnd.png"
    }

    //C++实例
    LoginQml {
        id: loginID
    }

    function  dlgConfirm(){
        console.log("dlg->yes");
        loginID.shutdown();

//        loginID.MemFunc();

        var ee = loginID.restart11();

        username.text = ee["usrname"]
        pwd.text=ee["pwd"]

        console.log(ee)

    }

    MaterialLabel {
        x: 1
        y: 1
        text:"半自动售票系统"
        anchors.bottom: login_center.top

        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        font.pixelSize: 25
        color: "#57A5F5"
    }

    Rectangle{
        id:login_center
        visible: true
        width: 500
        height: 300
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.color:"#a1a1a1"
        border.width:2
        smooth: true
        color:"#00000000"//rgba

        Row{
            spacing: 5
            anchors.verticalCenterOffset: -80
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            MaterialLabel{
                anchors.bottom: username.bottom

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.right

                text: "用户名:"
                color: "#ffffff"
                font.pixelSize: 16
            }

            TextField{
                id:username
                width: 160
                height: 30
                text: ""
                validator: RegExpValidator { regExp: /^\d{6}$/}//6位数字


                focus: true
                font.pixelSize: 18
                echoMode: TextInput.Normal
            }
        }

        Row{
            spacing: 5
            anchors.verticalCenterOffset: -10
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            MaterialLabel{
                anchors.bottom: pwd.bottom
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.right
                text: "密   码:"
                color: "#ffffff"
                font.pixelSize: 16
            }

            TextField{
                id:pwd
                width: 160
                height: 30
                text:""
                echoMode: TextInput.Password
                validator: RegExpValidator { regExp: /^\d{6}$/}//6位数字
            }
        }

        MaterialButton {
            x: 254
            y: 278
            width: 120
            height: 40
            text: "登录"
            anchors.verticalCenterOffset: 80
            anchors.horizontalCenterOffset: -165
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                //welcomeManage.openGitHubLink();
                login.visible= false;
            }
        }

        MaterialButton {
            x: 254
            y: 278
            width: 120
            height: 40
            text: "关机"
            anchors.verticalCenterOffset: 80
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {

                loginID.checkPWD(username.text,pwd.text);

                console.log("shut down");
            }
        }

        MaterialButton {
            x: 254
            y: 278
            width: 120
            height: 40
            text: "重启"
            anchors.verticalCenterOffset: 80
            anchors.horizontalCenterOffset: 165
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                dlgAlert.show("提示","是否确认重启?",dlgConfirm);

                console.log("restart");
            }
        }
    }


    MaterialLabel {
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        text: "当前版本19.11.06";
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignRight
        color: "#a1a1a1"
    }


    MaterialDialogAlert{
        id:dlgAlert
        positiveButtonText:"确定"
    }


    //dialog
    MaterialUI{
        id:materialUI
        z:2
        anchors.fill: parent
        dialogCancelText: "取消"
        dialogOKText: "确定"
    }
}
