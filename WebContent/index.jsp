<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Cute+Font" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<style type="text/css">
   *{
      font-family: 'Cute Font', cursive
   }
</style>
<script type="text/javascript">
   $('document').ready(function(){
      $('#getNumber').click(function(){
         var count = $("#count").val();
         $.ajax({
            type: 'GET',
             dataType: 'json',
             url: '/LottoProject/LottoNumber',
             data: {count: count},
             success: function(result) {
                $('#number1').val(result.drwtNo1);
                $('#number2').val(result.drwtNo2);
                $('#number3').val(result.drwtNo3);
                $('#number4').val(result.drwtNo4);
                $('#number5').val(result.drwtNo5);
                $('#number6').val(result.drwtNo6);
                $('#bouns').val(result.bnusNo);
                 
             },
             error: function (request,status, error) {
                 console.log(error);
                 alert(status);
             }
         });
      });
      $('#grade').click(function(){
            var count = $('#count').val();
            var gradenum = new Array();
            var num = new Array();
            num[0] = $('#number1').val();
            num[1] = $('#number2').val();
            num[2] = $('#number3').val();
            num[3] = $('#number4').val();
            num[4] = $('#number5').val();
            num[5] = $('#number6').val();
            
            for(var i = 0; i < 6-1; i++) {
             for(var j = 0; j < 6-i-1; j++){
              if(num[j] > num[j+1]) {
               var temp=num[j];
               num[j] = num[j+1];
               num[j+1] = temp;      
              }
             }
            }
            $.ajax({
             type: 'GET',
                dataType: 'json',
                url: '/LottoProject/LottoNumber',
                data: { "count" : count },
                success: function(result) {
                 var cnt = 0;
                 
                 gradenum[0] = result.drwtNo1;
                 gradenum[1] = result.drwtNo2;
                 gradenum[2] = result.drwtNo3;
                 gradenum[3] = result.drwtNo4;
                 gradenum[4] = result.drwtNo5;
                 gradenum[5] = result.drwtNo6;
                 gradenum[6] = result.bnusNo;
              
              for(var i = 0; i < 6; i++){
               for(var j = 0; j< 6; j++){
                if(num[i] == gradenum[j]){
                 cnt++;
                }       
               }
              }
              
              if(cnt == 6){
               $('#resultgrade').html('1등당첨');
              }else if(cnt == 5){
                    cnt=0;
                    for(var i = 0; i < 6; i++){
                         if(mynum[i] == gradenum[6]){
                            cnt++;
                         }       
                        }
                     if(cnt==1){
                      $('#resultgrade').html('2등당첨');
                     }else{
                   $('#resultgrade').html('3등당첨');
                  }
              }else if(cnt == 4){
               $('#resultgrade').html('4등당첨');
              }else if(cnt == 3){
               $('#resultgrade').html('5등당첨');
              }else{
               $('#resultgrade').html('당첨된것이없습니다.');
              }
                    
                },
                error: function (request,status, error) {
                    console.log(error);
                    alert(status);
                }
            });
           });
      
   });
</script>
</head>
<body>
<div class="container">
   <div class="jumbotron">
      <h1 class="display-4">안녕하세요.</h1>
      <p class="lead">나눔로또프로램입니다.</p>
      <hr class="my-4">
      <p> 기능참고사항<br/>
          1. 해당회차를입력하고번호가져올수있습니다.<br/>
          2. 입력한번호로해당회차와비교하여1등2등... 확인가능합니다.
      </p>
   </div>
   <div class="row">
      <div class="col-sm-8 mx-auto">
         <h3>해당회차가져오기</h3>
         해당회차<input type="text" class="form-control mb-2" id="count"/>
         <input type="button" class="btn btn-primary" value="가져오기" id="getNumber"/>
         <h3>번호입력하여등수확인하기</h3>
         첫번째번호: <input type="text" class="form-control mb-2" id="number1"/>
         두번째번호: <input type="text" class="form-control mb-2" id="number2"/>
         세번째번호: <input type="text" class="form-control mb-2" id="number3"/>
         넷번째번호: <input type="text" class="form-control mb-2" id="number4"/>
         다섯번째번호: <input type="text" class="form-control mb-2" id="number5"/>
         여섯번째번호: <input type="text" class="form-control mb-2" id="number6"/>
         보너스번호: <input type="text" class="form-control mb-2" id="bouns"/>
         <input type="button" class="btn btn-primary" value="확인하기" id="grade"/>
   <h3 id="resultgrade"></h3>
      </div>
   </div>
</div>
</body>
</html>