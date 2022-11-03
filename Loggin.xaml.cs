using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using System.Configuration;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using MySql.Data.MySqlClient;

namespace MultiLocation
{
    /// <summary>
    /// Interaction logic for Loggin.xaml
    /// </summary>
    public partial class Loggin : Window
    {
        MySqlConnection connexion;
        MySqlCommand commande;

        public Loggin()
        {
            InitializeComponent();
            connexion = new MySqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString);
            txtUtilisateur.Focus();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string authentification = "SELECT * FROM utilisateurs WHERE id_utilisateur = '" + txtUtilisateur.Text + "' AND Password = '" + txtPassword.Password + "'";
                commande = new MySqlCommand(authentification, connexion);
                connexion.Open();
                MySqlDataReader lecteur = commande.ExecuteReader();
                if (lecteur.Read())
                {
                    UtilisateurActif utilisateur = new UtilisateurActif();
                    utilisateur.IdUtilisateur = lecteur["id_utilisateur"].ToString();
                    utilisateur.Prenom = lecteur["Prenom"].ToString();
                    utilisateur.Nom = lecteur["Nom"].ToString();
                    Window1 gestionLocation = new Window1(utilisateur);
                    gestionLocation.Show();
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Oops... L'utilisateur ou le mot de passe est invalide.");
                    txtPassword.Password = string.Empty;
                    txtPassword.Focus();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connexion.Close();
            }
        }

        
    }
}
