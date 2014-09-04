using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/// <summary>
/// Created By: Brij Mohan
/// Website: http://techbrij.com
/// Object: Seat Reservation Sample
/// </summary>
public partial class SeatReservation : System.Web.UI.Page
{
    int tourID = 1;
    int chargePerSheet = 100;
    StarBusModel.StarBusEntities1 objEntities = new StarBusModel.StarBusEntities1();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            BindSeats();
        }       
    }

    void BindSeats(){         
        txtAmount.Text = chargePerSheet.ToString();
        string sel =  String.Join(",",(from b in objEntities.BookingDetails
                   join s in objEntities.SeatDetails on b.BookingID equals s.BookingID
                   where b.TourID == tourID 
                   select s.SeatID).ToArray());
        ClientScript.RegisterStartupScript(this.GetType(), "Init", "init([" + sel + "]);",true);
       
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        StarBusModel.BookingDetail objBooking = new StarBusModel.BookingDetail();
        objBooking.TourID = tourID;
        objBooking.Name = txtName.Text;
        objBooking.Phone = txtPhone.Text;
        objBooking.Amount = Convert.ToDecimal(Request.Form[txtAmount.ClientID]);
        string[] seats = Request.Form[txtSeatNo.ClientID].Split(new char[] { ',' });
        for (int i = 0; i < seats.Length; i++)
            objBooking.SeatDetails.Add(new StarBusModel.SeatDetail() { SeatID = Convert.ToInt32(seats[i]) });
        objEntities.BookingDetails.AddObject(objBooking);        
        objEntities.SaveChanges();
        BindSeats();
    }
}