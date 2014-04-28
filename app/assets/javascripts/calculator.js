$(document).ready(function() {
  calculatorController.bindEvents();
  MPGChart.init();
});

var calculatorController = {
  bindEvents: function() {
    $('#calculator form').on('submit', calculatorController.calculate);
  },
  calculate: function() {
    calculatorModel.calculateSavings();
    calculatorView.showSavings();
  }
}

var calculatorModel = {
  miles: 0,
  gasPrice: 0,
  mpg: 25,
  savings: 0,
  calculateSavings: function() {
    event.preventDefault();
    calculatorModel.assignMilesAndGasPrice();
    calculatorModel.determineSavings();
  },
  assignMilesAndGasPrice: function() {
    calculatorModel.miles = parseFloat($('input[name="Miles biked"').val());
    calculatorModel.gasPrice = parseFloat($('input[name="Cost of gas"').val());
  },
  determineSavings: function() {
    calculatorModel.savings = (calculatorModel.miles/calculatorModel.mpg) * calculatorModel.gasPrice;
  }
}

var calculatorView = {
  showSavings: function() {
    $('#savings p.answer').html("$ " + calculatorModel.savings.toFixed(2));
  }
}
