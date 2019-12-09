import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

import MainHelper 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    MainHelperQml{
        id:mainhelp_cc;
    }


    Button{
        id:btn;
        text: "点击";
        onClicked: {
            mainhelp_cc.setQRShowStr(showtext.text);
            console.log("clicked")
            img_preview.source = "";
            img_preview.source = "image://ImageProvider";
        }
    }

    TextField{
        id:showtext;
        text: "12346"
        anchors.left: btn.right
        anchors.leftMargin: 20
    }


    Image {
        id:img_preview
        cache: false;  //取消缓存
        anchors.centerIn: parent
        source: ""
        }

    Label{
        id:lbl;


    }


}

