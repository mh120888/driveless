var MPGChart = (function() {

  var chartData = {
  labels : [],
  datasets : [
      {
        fillColor : "rgba(0,50,100,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : []
      }
    ]
  }

  function bindEvents() {
    $('a#view-chart').on('click', grabData);
  }

  function grabData() {
    $.get( 'fillups.json', function( data ) {
      transformDataForChart(data);
    });
  }

  function transformDataForChart(data) {
    chartData.labels = [];
    chartData.datasets.data = [];
    for (var i = 0; i < data.length; i++) {
      chartData.labels.push(data[i].date_of_fillup);
      chartData.datasets[0].data.push(data[i].miles_driven/data[i].amount_of_gas)
    }
    drawChart(chartData);
  }

  function drawChart(data) {
    var ctx = document.getElementById("myChart").getContext("2d");
    var myNewChart = new Chart(ctx).Bar(data);
    $('a#view-chart').css('display', 'none');
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

// todo

// grab data from server
// format data for use in chart
// render chart