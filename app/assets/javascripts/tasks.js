document.addEventListener('turbolinks:load', function(){
  //ajax処理にてtaskを削除するための記述
  // document.querySelectorAll('.delete').forEach(function(a){
  //   a.addEventListener('ajax:success', function(){
  //     var td = a.parentNode;
  //     var tr = td.parentNode;
  //     tr.style.display = 'none';
  //   });
  // });


  document.querySelectorAll('td').forEach(function(td){
    td.addEventListener('mouseover',function(e){
      e.currentTarget.style.backgroundColor = '#eff';
    });

    td.addEventListener('mouseout',function(e){
      e.currentTarget.style.backgroundColor = '';
    });
  });
});
