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
using System.Configuration;

namespace Problema_2
{
    public partial class Form1 : Form
    {
        private SqlConnection connection;
        private SqlDataAdapter parent_adapter;
        private SqlDataAdapter child_adapter;
        private DataSet data;
        private DataRelation relation;

        public Form1()
        {
            InitializeComponent();
            this.FillData();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        void FillData()
        {
            String path = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            this.connection = new SqlConnection(path);

            this.data = new DataSet();
            String select_parent = ConfigurationManager.AppSettings.Get("select1");
            String parent = ConfigurationManager.AppSettings.Get("parent");
            this.parent_adapter = new SqlDataAdapter(select_parent, this.connection);
            this.parent_adapter.Fill(data, parent);

            String select_child = ConfigurationManager.AppSettings.Get("select2");
            String child = ConfigurationManager.AppSettings.Get("child");
            this.child_adapter = new SqlDataAdapter(select_child, this.connection);
            this.child_adapter.Fill(data, child);

            String FKName = ConfigurationManager.AppSettings.Get("FKName");
            String FKID = ConfigurationManager.AppSettings.Get("FKID");
            this.relation = new DataRelation(FKName, data.Tables[parent].Columns[FKID], data.Tables[child].Columns[FKID]);
            data.Relations.Add(relation);

            BindingSource bs_parent = new BindingSource();
            bs_parent.DataSource = data.Tables[parent];
            this.dataGridView1.DataSource = bs_parent;

            BindingSource bs_child = new BindingSource(bs_parent, FKName);
            this.dataGridView2.DataSource = bs_child;
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            String parent = ConfigurationManager.AppSettings.Get("parent");
            String child = ConfigurationManager.AppSettings.Get("child");
            SqlCommandBuilder builder = new SqlCommandBuilder(child_adapter);
            child_adapter.Update(data.Tables[child]);
        }
    }
}
