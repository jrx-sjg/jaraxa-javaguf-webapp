<guf-chart>
	<canvas ref="chart"></canvas>
	<style scoped type="css">
		:scope {
			display: block;
			position:relative;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}

		canvas {
			display: block;
			position:absolute;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.context = null;
		tag.chartObj = null;

		tag.on("mount", function() {
			//FIXME: Initial aspect ratio is wrong
			tag.context = tag.refs.chart.getContext("2d");
			tag.chartObj = new Chart(tag.context, {
				type: 'bar',
				data: {
					labels: [],
					datasets: [{
						label: 'Inbound Messages',
						fill: false,
						lineTension: 0.1,
			            backgroundColor: "rgba(73,144,226,1)",
			            borderColor: "rgba(73,144,226,1)",
			            borderCapStyle: 'butt',
			            borderDash: [],
			            borderDashOffset: 0.0,
			            borderJoinStyle: 'miter',
			            pointBorderColor: "rgba(73,144,226,1)",
			            pointBackgroundColor: "#fff",
			            pointBorderWidth: 1,
			            pointHoverRadius: 5,
			            pointHoverBackgroundColor: "rgba(73,144,226,1)",
			            pointHoverBorderColor: "rgba(220,220,220,1)",
			            pointHoverBorderWidth: 2,
			            pointRadius: 1,
			            pointHitRadius: 10,
			            data: [],
			            spanGaps: false
					}, {
						label: 'Outbound Messages',
						fill: false,
						lineTension: 0.1,
			            backgroundColor: "rgba(49,63,77,1)",
			            borderColor: "rgba(49,63,77,1)",
			            borderCapStyle: 'butt',
			            borderDash: [],
			            borderDashOffset: 0.0,
			            borderJoinStyle: 'miter',
			            pointBorderColor: "rgba(49,63,77,1)",
			            pointBackgroundColor: "#fff",
			            pointBorderWidth: 1,
			            pointHoverRadius: 5,
			            pointHoverBackgroundColor: "rgba(49,63,77,1)",
			            pointHoverBorderColor: "rgba(220,220,220,1)",
			            pointHoverBorderWidth: 2,
			            pointRadius: 1,
			            pointHitRadius: 10,
			            data: [],
			            spanGaps: true
					}]
				},
				options: {
					scales: {
						xAxes: [{
							stacked: true,
							ticks: {
								fontSize: 8
							}
						}],
						yAxes: [{
							stacked: true,
							ticks: {
								fontSize: 10,
								beginAtZero: true
							}
						}]
					},
					legend: {
						labels: {
							fontSize: 10
						}
					},
					responsive: true,
					maintainAspectRatio: false
				}
			});
		});

		tag.setData = function(axisX, axisY) {
			for (var i=0; i<axisY.length; i++) {
				tag.chartObj.chart.config.data.datasets[i].data = axisY[i];	
			}
			tag.chartObj.chart.config.data.labels = axisX;
			tag.chartObj.update();
		}
	</script>
</guf-chart>