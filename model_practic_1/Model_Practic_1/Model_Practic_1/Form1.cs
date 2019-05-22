using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Model_Practic_1
{
    public partial class Form1 : Form
    {
        SqlConnection dbConn;
        DataSet ds;
        SqlDataAdapter daUsers, daPosts;
        SqlCommandBuilder cb;
        BindingSource bsUsers, bsPosts;

        public Form1()
        {
            InitializeComponent();
        }

        private void ButtonUpdateDB_Click(object sender, EventArgs e)
        {
            daPosts.Update(ds, "Posts");
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            GetData();
            DGVUsers.DataSource = bsUsers;
            DGVPosts.DataSource = bsPosts;
        }

        private void GetData()
        {
            string path = @"Data Source = DESKTOP-1HMA8E2\SQLEXPRESS; Initial Catalog = model_practic_sgbd_1; Integrated Security = true";
            dbConn = new SqlConnection(path);

            daUsers = new SqlDataAdapter("SELECT * FROM Users", dbConn);
            daPosts = new SqlDataAdapter("SELECT * FROM Posts", dbConn);

            cb = new SqlCommandBuilder(daPosts);

            ds = new DataSet();

            daUsers.Fill(ds, "Users");
            daPosts.Fill(ds, "Posts");

            ds.Relations.Add("FK_Posts_User", ds.Tables["Users"].Columns["UserID"], ds.Tables["Posts"].Columns["UserID"]);

            bsUsers = new BindingSource();
            bsUsers.DataSource = ds;
            bsUsers.DataMember = "Users";

            bsPosts = new BindingSource();
            bsPosts.DataSource = bsUsers; // ! => the currently selected user; if we just write ds here, all entries in the post table will be displayed
            bsPosts.DataMember = "FK_Posts_User";

        }
    }
}
