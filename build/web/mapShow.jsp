<%-- 
    Document   : mapjsp
    Created on : 2019年1月31日, 下午2:46:25
    Author     : gry
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.util.*,db.*" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="百度地图,百度地图API，百度地图自定义工具，百度地图所见即所得工具" />
    <meta name="description" content="百度地图API自定义地图，帮助用户在可视化操作下生成百度地图" />
    <title>路灯智能管理</title>
    <!--引用百度地图API-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=QSSR8leStEMOuXLIXVcg6pvjndqegsc2"></script>

    <!-- Bootstrap -->
    <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">

    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>

    <script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>


</head>

<body>

<div>
        <div class="container">
            <div class="row">
                <br/>
                <h1>智能路灯数据管理</h1>
                <hr/>
                <br/>
            </div>

            <div class="row">
                <div class="col-lg-2">
                    <ul class="nav nav-pills nav-stacked">
                        <li class="active"><a href="mapShow.jsp">地图显示</a></li>
                        <li><a href="tableShow.jsp">数据详情</a></li>
                        <li><a href="figureShow.html">波形显示</a></li>
                    </ul>
                </div>

                <div class="col-lg-10">
                    <!--百度地图容器-->
                    <div class="col-md-12" style="width:100%;height:600px;border:#ccc solid 1px;font-size:12px" id="map"></div>
                </div>

            </div>
        </div>
    </div>

</body>
    
    <%
        data d=dataDAO.selectLast1();
        int offsetWidth=0;
        String state="正常运行";
        if(d.getValue()>45||d.getValue()<38)
        {
            offsetWidth=-46;
            state="出现故障";
        }
    %>
    
<script type="text/javascript">
    //创建和初始化地图函数：
    function initMap(){
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
        addMapOverlay();//向地图添加覆盖物
    }
    function createMap(){
        map = new BMap.Map("map");
        map.centerAndZoom(new BMap.Point(117.193071,39.131837),19);
    }
    function setMapEvent(){
        map.enableScrollWheelZoom();
        map.enableKeyboard();
        map.enableDragging();
        map.enableDoubleClickZoom()
    }
    function addClickHandler(target,window){
        target.addEventListener("click",function(){
            target.openInfoWindow(window);
        });
    }
    function addMapOverlay(){
        var markers = [
            {content:"正常运行，实时电压：40.000V",title:"001",imageOffset: {width:0,height:3},position:{lat:39.13161,lng:117.192519}},
            {content:"出现故障，实时电压：0V",title:"002",imageOffset: {width:-46,height:3},position:{lat:39.131718,lng:117.192698}},
            {content:"<%=state %>，实时电压：<%=d.getValue()%>V",title:"003",imageOffset: {width:<%=offsetWidth %>,height:3},position:{lat:39.131865,lng:117.192986}},
            {content:"可能故障，实时电压：30.000V",title:"004",imageOffset: {width:-69,height:3},position:{lat:39.132051,lng:117.193332}},
            {content:"正常运行，实时电压：40.000V",title:"005",imageOffset: {width:0,height:3},position:{lat:39.132246,lng:117.193709}},
            {content:"正常运行，实时电压：40.000V",title:"006",imageOffset: {width:0,height:3},position:{lat:39.132365,lng:117.193925}}
        ];
        for(var index = 0; index < markers.length; index++ ){
            var point = new BMap.Point(markers[index].position.lng,markers[index].position.lat);
            var marker = new BMap.Marker(point,{icon:new BMap.Icon("http://api.map.baidu.com/lbsapi/createmap/images/icon.png",new BMap.Size(20,25),{
                    imageOffset: new BMap.Size(markers[index].imageOffset.width,markers[index].imageOffset.height)
                })});
            var label = new BMap.Label(markers[index].title,{offset: new BMap.Size(20,5)});
            var opts = {
                width: 200,
                title: markers[index].title,
                enableMessage: false
            };
            var infoWindow = new BMap.InfoWindow(markers[index].content,opts);
            marker.setLabel(label);
            addClickHandler(marker,infoWindow);
            map.addOverlay(marker);
        };
    }
    //向地图添加控件
    function addMapControl(){
        var scaleControl = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
        scaleControl.setUnit(BMAP_UNIT_IMPERIAL);
        map.addControl(scaleControl);
        var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
        map.addControl(navControl);
        var overviewControl = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:true});
        map.addControl(overviewControl);
    }
    var map;

    var styleJson = [{
        "featureType": "land",
        "elementType": "geometry",
        "stylers": {
            "color": "#242f3eff"
        }
    }, {
        "featureType": "manmade",
        "elementType": "geometry",
        "stylers": {
            "color": "#242f3eff"
        }
    }, {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": {
            "color": "#17263cff"
        }
    }, {
        "featureType": "road",
        "elementType": "geometry.fill",
        "stylers": {
            "color": "#9e7d60ff"
        }
    }, {
        "featureType": "road",
        "elementType": "geometry.stroke",
        "stylers": {
            "color": "#554631ff"
        }
    }, {
        "featureType": "districtlabel",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#d69563ff"
        }
    }, {
        "featureType": "districtlabel",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#17263cff",
            "weight": 3
        }
    }, {
        "featureType": "poilabel",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#d69563ff"
        }
    }, {
        "featureType": "poilabel",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#17263cff",
            "weight": 3
        }
    }, {
        "featureType": "subway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "railway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "poilabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "subwaylabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "subwaylabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "tertiarywaysign",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "tertiarywaysign",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "provincialwaysign",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "provincialwaysign",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "nationalwaysign",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "nationalwaysign",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "highwaysign",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "highwaysign",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "green",
        "elementType": "geometry",
        "stylers": {
            "color": "#263b3eff"
        }
    }, {
        "featureType": "nationalwaysign",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#d0021bff"
        }
    }, {
        "featureType": "nationalwaysign",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#ffffffff"
        }
    }, {
        "featureType": "city",
        "elementType": "labels",
        "stylers": {
            "visibility": "on"
        }
    }, {
        "featureType": "city",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "city",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#d69563ff"
        }
    }, {
        "featureType": "city",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#17263cff"
        }
    }, {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#d69563ff"
        }
    }, {
        "featureType": "water",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#242f3eff"
        }
    }, {
        "featureType": "local",
        "elementType": "geometry.fill",
        "stylers": {
            "color": "#38414eff"
        }
    }, {
        "featureType": "local",
        "elementType": "geometry.stroke",
        "stylers": {
            "color": "#ffffff0"
        }
    }, {
        "featureType": "fourlevelway",
        "elementType": "geometry.fill",
        "stylers": {
            "color": "#38414eff"
        }
    }, {
        "featureType": "fourlevelway",
        "elementType": "geometry.stroke",
        "stylers": {
            "color": "#ffffff00"
        }
    }, {
        "featureType": "tertiaryway",
        "elementType": "geometry.fill",
        "stylers": {
            "color": "#38414eff"
        }
    }, {
        "featureType": "tertiaryway",
        "elementType": "geometry.stroke",
        "stylers": {
            "color": "#ffffff0"
        }
    }, {
        "featureType": "tertiaryway",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#759879ff"
        }
    }, {
        "featureType": "fourlevelway",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#759879ff"
        }
    }, {
        "featureType": "highway",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#759879ff"
        }
    }, {
        "featureType": "highway",
        "elementType": "geometry.fill",
        "stylers": {
            "color": "#9e7d60ff"
        }
    }, {
        "featureType": "highway",
        "elementType": "geometry.stroke",
        "stylers": {
            "color": "#554631ff"
        }
    }, {
        "featureType": "provincialway",
        "elementType": "geometry.fill",
        "stylers": {
            "color": "#9e7d60ff"
        }
    }, {
        "featureType": "provincialway",
        "elementType": "geometry.stroke",
        "stylers": {
            "color": "#554631ff"
        }
    }, {
        "featureType": "tertiaryway",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#1a2e1cff"
        }
    }, {
        "featureType": "fourlevelway",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#1a2e1cff"
        }
    }, {
        "featureType": "highway",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#1a2e1cff"
        }
    }, {
        "featureType": "nationalway",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#1a2e1cff"
        }
    }, {
        "featureType": "nationalway",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#759879ff"
        }
    }, {
        "featureType": "nationalway",
        "elementType": "geometry.fill",
        "stylers": {
            "color": "#9e7d60ff"
        }
    }, {
        "featureType": "nationalway",
        "elementType": "geometry.stroke",
        "stylers": {
            "color": "#554631ff"
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "geometry.fill",
        "stylers": {
            "color": "#9e7d60ff"
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "geometry.stroke",
        "stylers": {
            "color": "#554631ff"
        }
    }, {
        "featureType": "arterial",
        "elementType": "geometry.fill",
        "stylers": {
            "color": "#9e7d60ff"
        }
    }, {
        "featureType": "arterial",
        "elementType": "geometry.stroke",
        "stylers": {
            "color": "#554631fa"
        }
    }, {
        "featureType": "medicallabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "medicallabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "entertainmentlabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "entertainmentlabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "estatelabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "estatelabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "businesstowerlabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "businesstowerlabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "companylabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "companylabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "governmentlabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "governmentlabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "restaurantlabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "restaurantlabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "hotellabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "hotellabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "shoppinglabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "shoppinglabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "lifeservicelabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "lifeservicelabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "carservicelabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "carservicelabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "financelabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "financelabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "otherlabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "otherlabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "airportlabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "on"
        }
    }, {
        "featureType": "airportlabel",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#d69563ff"
        }
    }, {
        "featureType": "airportlabel",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#17263cff"
        }
    }, {
        "featureType": "airportlabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "highway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 6
        }
    }, {
        "featureType": "highway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 7
        }
    }, {
        "featureType": "highway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 8
        }
    }, {
        "featureType": "highway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 9
        }
    }, {
        "featureType": "highway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 10
        }
    }, {
        "featureType": "highway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 6
        }
    }, {
        "featureType": "highway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 7
        }
    }, {
        "featureType": "highway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 8
        }
    }, {
        "featureType": "highway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 9
        }
    }, {
        "featureType": "highway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 10
        }
    }, {
        "featureType": "nationalway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 6
        }
    }, {
        "featureType": "nationalway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 7
        }
    }, {
        "featureType": "nationalway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 8
        }
    }, {
        "featureType": "nationalway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 9
        }
    }, {
        "featureType": "nationalway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 10
        }
    }, {
        "featureType": "nationalway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 6
        }
    }, {
        "featureType": "nationalway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 7
        }
    }, {
        "featureType": "nationalway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 8
        }
    }, {
        "featureType": "nationalway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 9
        }
    }, {
        "featureType": "nationalway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 10
        }
    }, {
        "featureType": "nationalway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 6
        }
    }, {
        "featureType": "nationalway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 7
        }
    }, {
        "featureType": "nationalway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 8
        }
    }, {
        "featureType": "nationalway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 9
        }
    }, {
        "featureType": "nationalway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 10
        }
    }, {
        "featureType": "highway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 6
        }
    }, {
        "featureType": "highway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 7
        }
    }, {
        "featureType": "highway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 8
        }
    }, {
        "featureType": "highway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 9
        }
    }, {
        "featureType": "highway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 10
        }
    }, {
        "featureType": "provincialway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "8,9",
            "level": 8
        }
    }, {
        "featureType": "provincialway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "8,9",
            "level": 9
        }
    }, {
        "featureType": "provincialway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "8,9",
            "level": 8
        }
    }, {
        "featureType": "provincialway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "8,9",
            "level": 9
        }
    }, {
        "featureType": "provincialway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "8,9",
            "level": 8
        }
    }, {
        "featureType": "provincialway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "8,9",
            "level": 9
        }
    }, {
        "featureType": "cityhighway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 6
        }
    }, {
        "featureType": "cityhighway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 7
        }
    }, {
        "featureType": "cityhighway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 8
        }
    }, {
        "featureType": "cityhighway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 9
        }
    }, {
        "featureType": "cityhighway",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 10
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 6
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 7
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 8
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 9
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 10
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 6
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 7
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 8
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 9
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "6,10",
            "level": 10
        }
    }, {
        "featureType": "arterial",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "9,10",
            "level": 9
        }
    }, {
        "featureType": "arterial",
        "stylers": {
            "curZoomRegionId": "0",
            "curZoomRegion": "9,10",
            "level": 10
        }
    }, {
        "featureType": "arterial",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "9,10",
            "level": 9
        }
    }, {
        "featureType": "arterial",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "9,10",
            "level": 10
        }
    }, {
        "featureType": "arterial",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "9,10",
            "level": 9
        }
    }, {
        "featureType": "arterial",
        "elementType": "labels",
        "stylers": {
            "visibility": "off",
            "curZoomRegionId": "0",
            "curZoomRegion": "9,10",
            "level": 10
        }
    }, {
        "featureType": "building",
        "elementType": "geometry.fill",
        "stylers": {
            "color": "#2a3341ff"
        }
    }, {
        "featureType": "building",
        "elementType": "geometry.stroke",
        "stylers": {
            "color": "#1a212eff"
        }
    }, {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#759879ff"
        }
    }, {
        "featureType": "road",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#1a2e1cff"
        }
    }, {
        "featureType": "provincialway",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#759879ff"
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#759879ff"
        }
    }, {
        "featureType": "arterial",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#759879ff"
        }
    }, {
        "featureType": "provincialway",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#1a2e1cff"
        }
    }, {
        "featureType": "cityhighway",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#1a2e1cff"
        }
    }, {
        "featureType": "arterial",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#1a2e1cff"
        }
    }, {
        "featureType": "local",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "manmade",
        "elementType": "labels.text.fill",
        "stylers": {
            "color": "#d69563ff"
        }
    }, {
        "featureType": "manmade",
        "elementType": "labels.text.stroke",
        "stylers": {
            "color": "#17263cff"
        }
    }, {
        "featureType": "subwaystation",
        "elementType": "geometry",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "transportationlabel",
        "elementType": "labels.icon",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "transportationlabel",
        "elementType": "labels",
        "stylers": {
            "visibility": "off"
        }
    }, {
        "featureType": "estate",
        "elementType": "geometry",
        "stylers": {
            "color": "#2a3341ff"
        }
    }];


    initMap();

    map.setMapStyleV2({styleJson:styleJson});

</script>
</html>
