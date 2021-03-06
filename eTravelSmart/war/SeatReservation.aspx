﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SeatReservation.aspx.cs"
    Inherits="SeatReservation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        #mask
        {
            position: fixed;
            left: 0px;
            top: 0px;
            z-index: 4;
            opacity: 0.4;
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=40)"; /* first!*/
            filter: alpha(opacity=40); /* second!*/
            background-color: gray;
            display: none;
            width: 100%;
            height: 100%;
        }
        #holder
        {
            height: 200px;
            width: 550px;
            background-color: #F5F5F5;
            border: 1px solid #A4A4A4;
            margin-left: 10px;
        }
        #place
        {
            position: relative;
            margin: 7px;
        }
        #place a
        {
            font-size: 0.6em;
        }
        #place li
        {
            list-style: none outside none;
            position: absolute;
        }
        #place li:hover
        {
            background-color: yellow;
        }
        #place .seat
        {
            background: url("images/available_seat_img.gif") no-repeat scroll 0 0 transparent;
            height: 33px;
            width: 33px;
            display: block;
        }
        #place .selectedSeat
        {
            background-image: url("images/booked_seat_img.gif");
        }
        #place .selectingSeat
        {
            background-image: url("images/selected_seat_img.gif");
        }
        #place .row-3, #place .row-4
        {
            margin-top: 10px;
        }
        
        #seatDescription li
        {
            list-style: none outside none;
            padding-left: 35px;
            height: 35px;
            margin-top: 5px;
            float: left;
        }
        .popUp label
        {
            width: 4em;
            float: left;
            text-align: right;
            margin-right: 0em;
            display: block;
        }
        .popUp input
        {
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="mask">
    </div>
    <h2>
        Choose seats by clicking the corresponding seat in the layout below:</h2>
    <div id="holder">
        <ul id="place">
        </ul>
    </div>
    <div style="float: left;">
        <ul id="seatDescription">
            <li style="background: url('images/available_seat_img.gif') no-repeat scroll 0 0 transparent;">
                Available Seat</li>
            <li style="background: url('images/booked_seat_img.gif') no-repeat scroll 0 0 transparent;">
                Booked Seat</li>
            <li style="background: url('images/selected_seat_img.gif') no-repeat scroll 0 0 transparent;">
                Selected Seat</li>
            <li>
                <input type="button" id="btnShowNew" value="Book" /></li>
        </ul>
    </div>
    <div style="clear:both;padding-top:25px;">
    Visit <a href="http://techbrij.com">TechBrij</a> for more details.    
    </div>

    <asp:Panel ID="PanelPop" runat="server" Style="display: none; cursor: pointer; width: 250px;
        z-index: 111; background-color: White; position: absolute; left: 35%; top: 12%;
        border: outset 2px gray; text-align: center; padding: 10px" class="popUp">
        <p>
            <asp:Label ID="Label1" runat="server" Text="Name" AssociatedControlID="txtName"></asp:Label>
            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtName"
                runat="server" Display="Dynamic" ErrorMessage="Name is required.">*</asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Phone" AssociatedControlID="txtPhone"></asp:Label>
            <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtPhone"
                runat="server" Display="Dynamic" ErrorMessage="Phone is required.">*</asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Amount" AssociatedControlID="txtAmount"></asp:Label>
            <asp:TextBox ID="txtAmount" runat="server" ReadOnly="true"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAmount"
                Display="Dynamic" ErrorMessage="Amount is required.">*</asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:Label ID="Label4" runat="server" Text="Seat No." AssociatedControlID="txtSeatNo"></asp:Label>
            <asp:TextBox ID="txtSeatNo" runat="server" ReadOnly="true"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
            <input type="button" id="btnCancel" value="Cancel" onclick="HidePopup();" />
        </p>
    </asp:Panel>
    <script type="text/javascript">

        var settings = {
            rows: 5,
            cols: 15,
            rowCssPrefix: 'row-',
            colCssPrefix: 'col-',
            seatWidth: 35,
            seatHeight: 35,
            seatCss: 'seat',
            selectedSeatCss: 'selectedSeat',
            selectingSeatCss: 'selectingSeat'
        };
        var chargePerSheet;
        var init = function (reservedSeat) {
            var str = [], seatNo, className;
            for (i = 0; i < settings.rows; i++) {
                for (j = 0; j < settings.cols; j++) {
                    seatNo = (i + j * settings.rows + 1);
                    className = settings.seatCss + ' ' + settings.rowCssPrefix + i.toString() + ' ' + settings.colCssPrefix + j.toString();
                    if ($.isArray(reservedSeat) && $.inArray(seatNo, reservedSeat) != -1) {
                        className += ' ' + settings.selectedSeatCss;
                    }
                    str.push('<li class="' + className + '"' +
                                  'style="top:' + (i * settings.seatHeight).toString() + 'px;left:' + (j * settings.seatWidth).toString() + 'px">' +
                                  '<a title="' + seatNo + '">' + seatNo + '</a>' +
                                  '</li>');
                }
            }
            $('#place').html(str.join(''));
            chargePerSheet = $('#<%=txtAmount.ClientID %>').val();
        };

        //case I: Show from starting
        //init();

        //Case II: If already booked
        //var bookedSeats = [5, 10, 25];
        //init(bookedSeats);

        $('.' + settings.seatCss).live('click', function () {
            if ($(this).hasClass(settings.selectedSeatCss)) {
                alert('This seat is already reserved');
            }
            else {
                $(this).toggleClass(settings.selectingSeatCss);
            }
        });

        $('#btnShowNew').click(function () {
            var str = [];
            $.each($('#place li.' + settings.selectingSeatCss + ' a'), function (index, value) {
                str.push($(this).attr('title'));
            });
            if (str.length > 0) {
                $('#<%=txtAmount.ClientID %>').val(str.length * chargePerSheet);
                $('#<%=txtSeatNo.ClientID %>').val(str.join(','));
                ShowPopup();
            }
            else {
                alert('Select atleast one seat');
            }
        })

        function ShowPopup() {
            $('#mask').show();
            $('#<%=PanelPop.ClientID %>').show();
        }
        function HidePopup() {
            $('#mask').hide();
            $('#<%=PanelPop.ClientID %>').hide();
        }
    </script>
    </form>
</body>
</html>
