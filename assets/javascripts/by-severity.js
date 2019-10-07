$(function() {
  return $('div[data-by-severity]').each(function() {
    var data;
    data = $(this).data('by-severity');

    Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
    Chart.defaults.global.defaultFontColor = '#858796';

    var ctx = document.getElementById("by-severity");

    var myPieChart = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: ["Low", "Medium", "High"],
        datasets: [{
          data: data,
          backgroundColor: ['#36b9cc', '#f6c23e', '#e74a3b'],
          hoverBackgroundColor: ['#40828F', '#D6A339', '#B03524'],
          hoverBorderColor: "rgba(234, 236, 244, 1)",
        }],
      },
      options: {
        maintainAspectRatio: false,
        tooltips: {
          backgroundColor: "rgb(255,255,255)",
          bodyFontColor: "#858796",
          borderColor: '#dddfeb',
          borderWidth: 1,
          xPadding: 15,
          yPadding: 15,
          displayColors: false,
          caretPadding: 10,
        },
        legend: {
          display: false
        },
        cutoutPercentage: 80,
      }
    });
  });
});
