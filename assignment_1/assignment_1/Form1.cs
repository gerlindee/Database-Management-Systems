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

namespace assignment_1
{
    public partial class Form1 : Form
    {
        private SqlConnection connection;
        private SqlDataAdapter publisher_adapter;
        private SqlDataAdapter superhero_adapter;
        private DataSet data;
        private DataRelation relation;

        public Form1()
        {
            InitializeComponent();
            this.fillData();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        void fillData()
        {
            string path = @"Data Source = DESKTOP-1HMA8E2\SQLEXPRESS; Initial Catalog = comicbook_store; Integrated Security = true";
            this.connection = new SqlConnection(path);

            this.data = new DataSet();
            this.publisher_adapter = new SqlDataAdapter("SELECT * FROM Publisher", connection);
            this.superhero_adapter = new SqlDataAdapter("SELECT * FROM Superhero", connection);

            publisher_adapter.Fill(data, "Publisher");
            superhero_adapter.Fill(data, "Superhero");

            this.relation = new DataRelation("PublisherSuperhero", data.Tables["Publisher"].Columns["PublisherID"], data.Tables["Superhero"].Columns["PublisherID"]);
            data.Relations.Add(relation);

            BindingSource bs_publisher = new BindingSource();
            bs_publisher.DataSource = data.Tables["Publisher"];
            this.dataGridView1.DataSource = bs_publisher;

            BindingSource bs_superhero = new BindingSource(bs_publisher, "PublisherSuperhero");
            this.dataGridView2.DataSource = bs_superhero;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlCommandBuilder builder = new SqlCommandBuilder(superhero_adapter);
            superhero_adapter.Update(data.Tables["Superhero"]);

        }
    }
}
