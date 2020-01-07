import QtQuick 2.0
import QtQuick.Controls 1.4
import "qrc:/MaterialUI/"
import "qrc:/MaterialUI/Interface/"


Rectangle {
    id:ui_unpayAreaUpdate
    anchors.fill: parent
    width: parent.width
    height: parent.height
    opacity: 100
    color: "#fafafa"

    Image {
        id: backgroundImg
        anchors.fill: parent
        //source: "file:./img/backgnd.png"
    }

    MaterialButton{
        id:btn;
        x:100
        y:20
        width: 120
        height: 42
        text: "test"
        checkable: true
        checked: true

        onClicked: {
            fegrid.visible = false;
        }
    }


    MaterialCheckBox{
        id:checkboo
        x:100
        y:50
        text: "显示站点"
        checked: true
        onCheckedChanged: {
            fegrid.visible = checkedState;
        }

    }



    MaterialUI {
            id: materialUI
            z: 2
            anchors.fill: parent
            dialogCancelText: "取消"
            dialogOKText: "确定"
        }

//    Column
    Grid
    {
        id:fegrid
        anchors.centerIn: parent
        rows: 3;
        columns: 3;
        rowSpacing: 4;
        columnSpacing: 4;
        flow: Grid.LeftToRight ;

        add:Transition {
            NumberAnimation{ properties: "x"; duration: 500 }
        }

        move: Transition {
            NumberAnimation{ properties: "x"; duration: 500 }
        }


        Component.onCompleted:{
              //ListPair_SS lspss
              function clickedBtn(idStation)
              {
                  console.log("station id:" + idStation);
              }

              //创建组件
              var component = Qt.createComponent("qrc:/MaterialUI/Interface/MaterialButton.qml")
              for(var i = 0;i < 9;++i)
              {
                  //创建对象
                  var sprite = component.createObject(fegrid,{text:"动态MyButton" + i,idPropertyText:i})
                  //链接信号和槽
                  sprite.onIdPropertyclicked.connect(clickedBtn);


              }
          }
    }
}
