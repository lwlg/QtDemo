import QtQuick 2.0

Item {

    property var stationsArry:[]

    Component.onCompleted: {
        console.debug("linePage");
    }

//    Text {
//        id: linee
//        text: qsTr("text line")
//        color: "#ffffff"
//    }


    Rectangle {
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
                //创建组件
                var component = Qt.createComponent("qrc:/SationBtn.qml")
                 if (component.status === Component.Ready) {

                     for(var i = 0;i < stationsArry.length;++i)
                     {
                         //创建对象
                         var sprite = component.createObject(fegrid,{text:"动态MyButton" + i,idPropertyText:i})
                         //链接信号和槽
//                         sprite.onIdPropertyclicked.connect(clickedBtn);
                     }
                 }
                 console.log("?????????????????????")

            }
        }
    }



}

