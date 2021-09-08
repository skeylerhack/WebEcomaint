define(['_MasterPageController', '_MenuPageController', '_DetailsModalController', 'datatables-bootstrap', 'bootstrap-select'], function (module, menu, modal) {
    var LeaderShip = (function () {
        var app = angular.module('LeaderShipPage', [])
        app.controller('LeaderShipController', function ($scope, $compile) {
            var Main = module.Main
            var Languages = module.Languages
            var Convert = module.Convert
            var InfoDetails = modal
            var Loading = module.Loading
            var Alert = module.Alert
            var MainMenu = menu
            var BuildTreeView = module.BuildTreeView
            var menuID = 'mnuLeaderShip'
            var currentNamePage = 'LeaderShipWeb'
            var change = false
            var buttonFloat = [
                {
                    "id": "btnMain",
                    "url": "#",
                    "icon": "<i class='fa fa-angle-double-up'></i>"
                },
                {
                    "id": "btnSave",
                    "url": "#",
                    "icon": "<i class='fa fa-floppy-o'></i>",
                    "lang": "btnGhi",
                    "func": "fn.CheckValidateControl"
                },
                {
                    "id": "btnRefresh",
                    "icon": "<i class='fa fa-refresh'></i>",
                    "lang": "btnRefresh",
                    "url": urlResetLeaderShip
                }
            ]
            var Action = {
                add: 0, edit: 1
            }
            var vars = {}
            var bindVariables = function () {
                return {
                    $action: Action.add,
                }
            }
            var fnPrivate = {

            }

            var method
            $scope.fn = {
                Init: function () {
                    global.CurrentNamePage = currentNamePage
                    MainMenu.fn.SetActive(menuID);
                    Languages.fn.AutoChangeLanguage()
                    Main.fn.InitButtonFloat(buttonFloat)
                    vars = bindVariables();
                    method = fnPrivate;
                    $(".select2").select2(
                        {
                            theme: "classic"
                        });
                    $('#tbShowListDeails tbody tr td input').on('click', '', function () {
                        var rowchon = $(this).parent().parent().attr("data-id");
                        if ($(this).is(":checked")) {
                            if ($(this).attr("data-chon") == 'yes') {
                                $('#tbShowListDeails tbody tr[data-id="'+rowchon+'"] td input[type=checkbox][data-chon="no"]').prop('checked', false);
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon +'"] td input[type=checkbox][data-chon="na"]').prop('checked', false);
                            }

                            if ($(this).attr("data-chon") == 'no') {
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon +'"] td input[type=checkbox][data-chon="yes"]').prop('checked', false);
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon +'"] td input[type=checkbox][data-chon="na"]').prop('checked', false);
                            }

                            if ($(this).attr("data-chon") == 'na') {
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon +'"] td input[type=checkbox][data-chon="no"]').prop('checked', false);
                                $('#tbShowListDeails tbody tr[data-id="' + rowchon +'"] td input[type=checkbox][data-chon="yes"]').prop('checked', false);
                            }
                        }
                    });
                },
                CheckValidateControl: function () {
                    var lstLeadDetails = new  Array();
                    var i = 0;
                    $('#tbShowListDeails tbody tr').each(function (i, obj) {
                        if (!this.rowIndex) return;
                        lstLeadDetails[i] = new Object();
                        lstLeadDetails[i].ID = $(this).attr('data-id');
                        lstLeadDetails[i].STT = this.cells[0].innerHTML;
                        lstLeadDetails[i].IDLeadership = this.cells[1].innerHTML;
                        lstLeadDetails[i].Content = this.cells[2].innerHTML;
                        lstLeadDetails[i].Yes = $(obj).closest('tr').find('input[type=checkbox][data-chon="yes"]').is(":checked");
                        lstLeadDetails[i].No = $(obj).closest('tr').find('input[type=checkbox][data-chon="no"]').is(":checked");
                        lstLeadDetails[i].NA = $(obj).closest('tr').find('input[type=checkbox][data-chon="na"]').is(":checked");
                        i = i + 1;
                    });
                    $.ajax({
                        url: urlSaveLeaderShip,
                        type: "post",
                        data: { TuNgay: $("#fromDate").val(), User: $("#cbReport").val(), DataDetails: JSON.stringify(lstLeadDetails)},
                        success: function (data) {
                            if (data.Message === 'success') {
                                alert("thanh cong");
                            }
                            else {
                                Alert.fn.Show(global.TypeLanguage == 0 ? "Cập nhật chứng từ không thành công!" : "Failed to Update voucher!", Alert.Type.warning);
                            }
                        }
                    });
                }
            }
        })
        app.init = function () {
            angular.bootstrap(document, ['LeaderShipPage'])
        }
        return app;
    })();
    $(function () {
        LeaderShip.init()
    });
})