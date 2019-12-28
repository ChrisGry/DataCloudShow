<%-- 
    Document   : tableShow
    Created on : 2019年1月28日, 下午2:50:27
    Author     : gry
--%>

<%@ page contentType="text/html" language="java" import="java.util.*,db.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>数据显示</title>

        <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">

        <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>

        <script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    
    </head>
    <body>
    
    <% 
        int pageIndex=1;
        if(request.getParameter("pageIndex")!=null)
        {
            pageIndex=Integer.valueOf(request.getParameter("pageIndex"));
        }
        
        int pageSize=20;
        
        int low=(pageIndex-1)*pageSize;
        int high=low+pageSize;  

        List<data> dlist=dataDAO.selectAll(); 
        int totalPage=dlist.size()/30+1;
        
        if(high>dlist.size())
        {
            high=dlist.size();
        }
        
    %>
        
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
                        <li><a href="mapShow.jsp">地图显示</a></li>
                        <li class="active"><a href="tableShow.jsp">数据详情</a></li>
                        <li><a href="figureShow.html">折线图显示</a></li>
                    </ul>
                </div>

                <div class="col-lg-10">
                    
                    <form role="form" id="form1" class="form-horizontal" action="tableShow.jsp" method="get">
                        <input type="hidden" name="pageIndex" id="pageIndex"  value="1">
                        <div class="form-group" style="text-align: center;">
                            <button class="btn btn-info" type="button" onclick="turnTopPage()">上一页</button>  
                            <label>第<%=pageIndex %>页</label>
                            <label>共<%=totalPage %>页</label>
                            <button class="btn btn-info" type="button" onclick="turnBottomPage()">下一页</button>
                        </div>
                    </form>
                    
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>录入时间</th>
                                <th>设备编号</th>
                                <th>设备型号</th>
                                <th>从机地址</th>
                                <th>从机序号</th>
                                <th>数据点</th>
                                <th>电压值/V</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% 
                               
                               for(int i=low;i<high;i++)
                               { 
                                   %>
                                    <tr>
                                        <td><%=dlist.get(i).getDatetime() %></td>
                                        <td><%=dlist.get(i).getDeviceId() %></td>
                                        <td><%=dlist.get(i).getDeviceName() %></td>
                                        <td><%=dlist.get(i).getSlaveAddr() %></td>
                                        <td><%=dlist.get(i).getSlaveIndex() %></td>
                                        <td><%=dlist.get(i).getId() %></td>
                                        <td><%=dlist.get(i).getValue() %></td>
                                    </tr>
                                   <%
                               }
                            %>
                               
                            
                        </tbody>
                        
                    </table>
                </div>

            </div>
        </div>
        
    </div>
        
    <script type="text/javascript">
        
        var pageIndex=<%=pageIndex %>;
        var totalPage=<%=totalPage %>;
        console.log(pageIndex);
        //上一页
        function turnTopPage(){
            if(pageIndex==1){
                return;
            }else{
                document.getElementById("pageIndex").value=pageIndex-1;
                document.getElementById("form1").submit();
            }
        }
     //下一页
        function turnBottomPage(){
            if(pageIndex>=totalPage){    
                return;
            }else{
                document.getElementById("pageIndex").value=pageIndex+1;
                document.getElementById("form1").submit();
            }
        }
        
    </script>
                            
    </body>
</html>
