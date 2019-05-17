using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Threading;

namespace Laborator_3
{
    class Program
    {
        static int Runs = 10;
        
        static void firstThread()
        {
            string path = @"Data Source = DESKTOP-1HMA8E2\SQLEXPRESS; Initial Catalog = comicbook_store; Integrated Security = true";
            SqlConnection connection = new SqlConnection(path);
            connection.Open();

            try
            {
                SqlTransaction transaction = connection.BeginTransaction();
                SqlCommand command = new SqlCommand("deadlock1", connection, transaction);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.ExecuteNonQuery();
                transaction.Commit();
                Console.WriteLine("First transaction committed;");
            } catch (SqlException exception)
            {
                Console.WriteLine("First transaction has been chosen as deadlock victim - restarting;");
                if (Runs > 0)
                {
                    Runs = Runs - 1;
                    firstThread();
                } else
                {
                    Console.WriteLine("Number of runs has expired;");
                }
            }
        }

        static void secondThread()
        {
            string path = @"Data Source = DESKTOP-1HMA8E2\SQLEXPRESS; Initial Catalog = comicbook_store; Integrated Security = true";
            SqlConnection connection = new SqlConnection(path);
            connection.Open();

            try
            {
                SqlTransaction transaction = connection.BeginTransaction();
                SqlCommand command = new SqlCommand("deadlock2", connection, transaction);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.ExecuteNonQuery();
                transaction.Commit();
                Console.WriteLine("Second transaction committed;");
            } catch (SqlException exception)
            {
                Console.WriteLine("Second transaction has been chosen as deadlock victim - restarting;");
                if (Runs > 0)
                {
                    Runs = Runs - 1;
                    firstThread();
                }
                else
                {
                    Console.WriteLine("Number of runs has expired;");
                }
            }
        }

        static void Main(string[] args)
        {
            Thread thread1 = new Thread(new ThreadStart(firstThread));
            Thread thread2 = new Thread(new ThreadStart(secondThread));
            thread1.Start();
            thread2.Start();
            thread1.Join();
            thread2.Join();
            Console.Write("done");
            Console.ReadKey();

        }
    }
}
