$(function() {
  return $('div[data-by-category]').each(function() {
    var data;
    data = $(this).data('by-category');

    Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
    Chart.defaults.global.defaultFontColor = '#858796';

    var ctx = document.getElementById("myPieChart");
    var myPieChart = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: ["Security", "Bug risk", "Performance", "Complexity", "Unused Code", "Duplication", "Style"],
        datasets: [{
          data: data,
          backgroundColor: ['#e74a3b', '#f6c23e', '#36b9cc', '#1cc88a', '#4e73df', '#858796', '#1cc88a'],
          hoverBackgroundColor: ['#B03524', '#D6A339', '#40828F', '#3C835F', '#234EB7', '#5A5C68', '#3C835F'],
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
      },
    });
  });
});
