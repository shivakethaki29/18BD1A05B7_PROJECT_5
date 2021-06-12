<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Patient Portal</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

	<script>
	function o2valid() 
	{
	     var x = document.getElementById("vital").value;
	     if (x<0 || x>90)
	     {
	            alert("if oxygen level is greater than 90 then no need to consult a doctor. You are fine...")
	            //document.getElementById("vital").value="";
	     }
	}
	
	function tempvalid() 
	{
	     var x = document.getElementById("vital1").value;
	     if (x<0 || x>110)
	     {
	            alert("enter valid temperature")
	            document.getElementById("vital1").value="";
	     }
	}
	
	function mobvalid() 
	{
		 var mn=document.getElementById("vital2").value;
         var mr=/^[6-9][0-9]{9}$/;
         if(!mr.test(mn))
         {
             alert("enter valid mobile number")
             document.getElementById("vital2").value="";
         }
	     
	}
	
	</script>

</head>
<body>
	<div class="container">
		<label>Enter Oxygen Levels :</label>
		<input class="form-control form-control-sm" type="text" name="vital" id="vital" onChange="o2valid()" style="display:inline-block; width:300px;margin-top:25px;"">
		<br>
		<label>Enter Temperature :</label>
		<input class="form-control form-control-sm" type="text" name="vital1" id="vital1" onChange="tempvalid()" style="display:inline-block; width:300px;margin-top:25px;"">
		<br>
		<label>Enter Contact Number :</label>
		<input class="form-control form-control-sm" type="text" name="vital2" id="vital2" onChange="mobvalid()" style="display:inline-block; width:300px;margin-top:25px;"">
		<br>
		<button onclick="sendVitals();" class="btn btn-success btn-sm">Submit</button>
		<br /><br />
		<table id="example" class="table">
			<thead>
				<tr>
					<th>Doctor</th>
					<th>Medicine</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				</tr>
			</tbody>
		</table>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script>
		var websocket=new WebSocket("ws://localhost:8080/WebSocket/VitalCheckEndPoint");
		websocket.onmessage=function processVital(vital){
			var jsonData=JSON.parse(vital.data);
			if(jsonData.message!=null)
			{
				var details=jsonData.message.split(',');
				var row=document.getElementById('example').insertRow();
				if(details.length>2)
				{
					row.innerHTML="<td>"+details[0]+"</td><td>"+details[1]+"</td><td>"+details[2]+"</td>";		
				}
				else
				{
					alert(details[0]+" has summoned an ambulance");
					row.innerHTML="<td>"+details[0]+"</td><td></td><td>"+details[1]+"</td>";		
				}
			}
		}
		function sendVitals()
		{
			//alert(vital.value);
			//alert(vital1.value);
			websocket.send(vital.value+','+vital1.value+','+vital2.value);
			vital.value="";
			vital1.value="";
			vital2.value="";
		}
	</script>
</body>
</html>