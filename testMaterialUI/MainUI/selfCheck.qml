
import QtQuick 2.3
import QtQuick 2.5
import QtQuick.Controls 1.4
import "qrc:/MaterialUI/Interface/"
import "qrc:/MaterialUI/"


Item {
    id: selfCheckForm
    width: parent.width
    height: parent.height
    opacity: 100

    //C++实例
    function test(){
        console.debug("call test");

    }

    function clickedBtn(idStation)
    {
        console.log("station id:" + idStation);
    }

    property var page: [
        {title:"项目1",qsrc:"qrc:/MainUI/Login.qml"},
        {title:"项目2",qsrc:"qrc:/MainUI/test.qml"}
    ]

    property var linesParam: [
        {lineID:"01",lineName:"1号线"},
        {lineID:"02",lineName:"2号线"}
    ]

    property var stationsParam: [
        {SID:"0101",SName:"站路1"},
        {SID:"0102",SName:"站路2"},
        {SID:"0103",SName:"站路3"}
    ]


    function createTab() {

        for(var ii = 0; ii < page.length; ii++){
            var component = Qt.createComponent(page[ii].qsrc);

            if (component.status === Component.Ready) {

                testTab.testCrea(page[ii].title,component);

                console.log("dddddd",page[ii].title);
            }
        }
    }


    function createTab11() {

         for(var ii = 0; ii < linesParam.length; ii++){
             var component = Qt.createComponent("qrc:/LinePage.qml");

             if (component.status === Component.Ready) {
                 component.stationsArry = stationsParam;
                 console.log(">>>>>>",component.stationsArry.length);

                 testTab.testCrea(linesParam[ii].lineName,component);
             }
         }

    }

    Component.onCompleted: {
        createTab11();
        console.debug("selfCheck");
    }


    Image {
        id: backgroundImg
        anchors.fill: parent
        source: "file:../img/backgnd.png"
    }

    Grid
    {
            id:fegrid
            anchors.centerIn: parent
            rows: 3;
            columns: 3;
            rowSpacing: 4;
            columnSpacing: 4;
            flow: Grid.LeftToRight ;
    }

    //测试按钮
    MaterialButton{
        id:selfCheckbtn
        text: "testdd"
        checkable: true
        onClicked: {
//            createTab();

        }
    }

    MaterialTabs{
        id:testTab
        width: parent.width
        height: parent.height
        tabSource:[ ]
    }
}
