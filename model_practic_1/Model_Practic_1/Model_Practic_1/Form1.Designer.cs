namespace Model_Practic_1
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.DGVUsers = new System.Windows.Forms.DataGridView();
            this.DGVPosts = new System.Windows.Forms.DataGridView();
            this.ButtonUpdateDB = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.DGVUsers)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.DGVPosts)).BeginInit();
            this.SuspendLayout();
            // 
            // DGVUsers
            // 
            this.DGVUsers.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DGVUsers.Location = new System.Drawing.Point(28, 30);
            this.DGVUsers.Name = "DGVUsers";
            this.DGVUsers.RowTemplate.Height = 24;
            this.DGVUsers.Size = new System.Drawing.Size(803, 199);
            this.DGVUsers.TabIndex = 0;
            // 
            // DGVPosts
            // 
            this.DGVPosts.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DGVPosts.Location = new System.Drawing.Point(28, 253);
            this.DGVPosts.Name = "DGVPosts";
            this.DGVPosts.RowTemplate.Height = 24;
            this.DGVPosts.Size = new System.Drawing.Size(803, 195);
            this.DGVPosts.TabIndex = 1;
            // 
            // ButtonUpdateDB
            // 
            this.ButtonUpdateDB.Location = new System.Drawing.Point(695, 466);
            this.ButtonUpdateDB.Name = "ButtonUpdateDB";
            this.ButtonUpdateDB.Size = new System.Drawing.Size(136, 41);
            this.ButtonUpdateDB.TabIndex = 2;
            this.ButtonUpdateDB.Text = "Update Database";
            this.ButtonUpdateDB.UseVisualStyleBackColor = true;
            this.ButtonUpdateDB.Click += new System.EventHandler(this.ButtonUpdateDB_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(904, 539);
            this.Controls.Add(this.ButtonUpdateDB);
            this.Controls.Add(this.DGVPosts);
            this.Controls.Add(this.DGVUsers);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.DGVUsers)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.DGVPosts)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView DGVUsers;
        private System.Windows.Forms.DataGridView DGVPosts;
        private System.Windows.Forms.Button ButtonUpdateDB;
    }
}

