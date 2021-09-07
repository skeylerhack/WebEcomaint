﻿define(['_MasterPageController', '_MenuPageController', 'highcharts'], function (module, menu) {
    var DashCharts = (function () {
        var app = angular.module('DashChartsPage', [])
        app.controller('DashChartsController', function ($scope) {
            var Languages = module.Languages
            var Loading = module.Loading
            var MainMenu = menu
            $scope.fn = {
                Init: function () {
                    global.CurrentNamePage = 'DashboardWeb'
                    Languages.fn.AutoChangeLanguage()
                    MainMenu.fn.SetActive('mnuDashboard');
                    $.post(urlGetThongTinDevice, function (data) {
                        if (data.length > 0) {
                            $('#load').highcharts({
                                chart: {
                                    backgroundColor: null,
                                    height: 290,
                                    marginLeft: 50,
                                    marginRight: 50,
                                    marginBottom: 80,
                                    marginTop: 40,
                                    plotBackgroundColor: 'none',
                                    plotBorderWidth: null,
                                },
                                title: {
                                    text: (global.TypeLanguage == 0 ? "Tổng máy: " : "Sum device: ") + $('#somay').val()
                                },
                                tooltip: {
                                    formatter: function () {
                                        return this.point.name + ': ' + this.y + '/' + $('#somay').val()
                                    }
                                },

                                legend: {
                                    itemStyle: {
                                        fontWeight: 'bold'
                                    },
                                    borderWidth: 0
                                },
                                plotOptions: {
                                    pie: {
                                        allowPointSelect: true,
                                        cursor: 'pointer',
                                        dataLabels: {
                                            enabled: false//$(window).width() > 450 ? true : false
                                        },
                                        showInLegend: true// $(window).width() > 450 ? false : true
                                    }
                                },
                                series: [
                                    {
                                        borderWidth: 0,
                                        borderColor: '#F1F3EB',
                                        shadow: true,
                                        type: 'pie',
                                        name: 'Income',
                                        innerSize: '45%',
                                        data: JSON.parse(data),
                                        dataLabels: {
                                            enabled: false
                                        },
                                        showInLegend: true
                                    }]
                            });
                        }
                    });
                    $.post(urlGetTinhHinhDevice, function (data) {
                        if (data.length > 0) {
                            $('#space').highcharts({
                                chart: {
                                    backgroundColor: null,
                                    height: 290,
                                    marginLeft: 50,
                                    marginRight: 50,
                                    marginBottom: 80,
                                    marginTop: 40,
                                    plotBackgroundColor: 'none',
                                    plotBorderWidth: null,
                                },

                                title: {
                                    text: null
                                },

                                tooltip: {
                                    formatter: function () {
                                        return this.point.name + ': <br><b> ' + this.y + '</b> %';
                                    }
                                },
                                legend: {
                                    itemStyle: {
                                        fontWeight: 'bold'
                                    },
                                    borderWidth: 0
                                },
                                plotOptions: {
                                    pie: {
                                        allowPointSelect: true,
                                        cursor: 'pointer',
                                        dataLabels: {
                                            enabled: false//$(window).width() > 450 ? true : false
                                        },
                                        showInLegend: true// $(window).width() > 450 ? false : true
                                    }
                                },
                                series: [
                                    {
                                        borderWidth: 0,
                                        borderColor: '#F1F3EB',
                                        shadow: true,
                                        type: 'pie',
                                        name: 'SiteInfo',
                                        data: JSON.parse(data)
                                    }]
                            });
                        }
                    });

                    var month = new Array();
                    month[0] = "Jan";
                    month[1] = "Feb";
                    month[2] = "Mar";
                    month[3] = "Apr";
                    month[4] = "May";
                    month[5] = "Jun";
                    month[6] = "Jul";
                    month[7] = "Aug";
                    month[8] = "Sep";
                    month[9] = "Oct";
                    month[10] = "Nov";
                    month[11] = "Dec";

                    var date = new Date();
                    var i1 = new Date(date.getFullYear(), date.getMonth() - 5, 1).getMonth();
                    var i2 = new Date(date.getFullYear(), date.getMonth() - 4, 1).getMonth();
                    var i3 = new Date(date.getFullYear(), date.getMonth() - 3, 1).getMonth();
                    var i4 = new Date(date.getFullYear(), date.getMonth() - 2, 1).getMonth();
                    var i5 = new Date(date.getFullYear(), date.getMonth() - 1, 1).getMonth();
                    var i6 = new Date(date.getFullYear(), date.getMonth() - 0, 1).getMonth();


                    var theMonths = ["January", "February", "March", "April", "May",
                        "June", "July", "August", "September", "October", "November", "December"];
                    theMonths = [month[i1], month[i2], month[i3], month[i4], month[i5], month[i6]];

                    $.post(urlGetTinhHinhPBT, function (data) {
                        if (data.length > 0) {
                            $('#linechart').highcharts({
                                chart: {
                                    type: 'line',
                                    backgroundColor: 'transparent',
                                    height: 304,
                                    marginLeft: 80,
                                    marginRight: 80,
                                    marginBottom: 80,
                                    marginTop: 20,
                                    plotBackgroundColor: 'none',
                                    plotBorderWidth: null,
                                    plotShadow: false,
                                },
                                tooltip: {
                                    valueSuffix: ''
                                },

                                title: {
                                    text: ''
                                },
                                xAxis: {
                                    categories: theMonths
                                },

                                yAxis: {
                                    title: {
                                        text: 'Số phiếu'
                                    }
                                },
                                legend: {
                                    itemStyle: {
                                        fontWeight: 'bold'
                                    },
                                    borderWidth: 0
                                },
                                plotOptions: {
                                    line: {
                                        dataLabels: {
                                            enabled: true
                                        },
                                        enableMouseTracking: true,
                                        showInLegend: true,
                                        marker: {
                                            enabled: true
                                        },
                                        lineWidth: 5,
                                        //pointStart: newDate.getMonth()
                                    }
                                },

                                series: JSON.parse(data)
                            });
                        }
                    });
                    $.post(urlGetTinhHinhPBTColumn, function (data) {
                        if (data.length > 0) {
                            $('#importantchart').highcharts({
                                chart: {
                                    type: 'column',
                                    backgroundColor: 'transparent',
                                    height: 304,
                                    marginLeft: 80,
                                    marginRight: 80,
                                    marginBottom: 80,
                                    marginTop: 20,
                                    plotBackgroundColor: 'none',
                                    plotBorderWidth: null,
                                    plotShadow: false,
                                },
                                yAxis: {
                                    title: {
                                        text: 'Số phiếu'
                                    }
                                },
                                title: {
                                    text: ''
                                },
                                xAxis: {
                                    categories: theMonths
                                },

                                credits: {
                                    enabled: false
                                },
                                legend: {
                                    itemStyle: {
                                        fontWeight: 'bold'
                                    },
                                    borderWidth: 0
                                },
                                plotOptions: {
                                    column: {
                                        dataLabels: {
                                            enabled: true
                                        },
                                        showInLegend: true,
                                        marker: {
                                            enabled: true
                                        },
                                        borderWidth: 0
                                    }
                                },
                                series: JSON.parse(data)
                            });
                        }
                    });
                }
            }
        })
        app.init = function () {
            angular.bootstrap(document, ['DashChartsPage']);
        }
        return app;
    })();
    $(function () {
        DashCharts.init()
    });
})