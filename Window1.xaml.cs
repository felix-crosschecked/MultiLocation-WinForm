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
using System.Data;

namespace MultiLocation
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        MySqlConnection connexion;
        UtilisateurActif utilisateur;
        MySqlDataAdapter db;
        MySqlCommand commande;
        DataSet dsMultiLocation = new DataSet();
        DataRow location;
        DataRow client;
        DataRow vehicule;
        DataRow terme;
        bool nouveau = false;
        bool editMode = false;
        bool locationActive = false;
        bool infoTexte = false;
        bool selection = false;
        int statut = -1;

        public Window1(UtilisateurActif actif)
        {
            InitializeComponent();
            utilisateur = actif;
            connexion = new MySqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString);           
        }

        private void MultiLocation_Loaded(object sender, RoutedEventArgs e)
        {
            db = new MySqlDataAdapter("sp_SelectLocation", connexion);
            db.SelectCommand.CommandType = CommandType.StoredProcedure;
            db.FillSchema(dsMultiLocation, SchemaType.Mapped, "locations");
            db.Fill(dsMultiLocation, "locations");

            db = new MySqlDataAdapter("sp_SelectClients", connexion);
            db.SelectCommand.CommandType = CommandType.StoredProcedure;
            db.FillSchema(dsMultiLocation, SchemaType.Mapped, "clients");
            db.Fill(dsMultiLocation, "clients");

            db = new MySqlDataAdapter("sp_SelectVehicules", connexion);
            db.SelectCommand.CommandType = CommandType.StoredProcedure;
            db.FillSchema(dsMultiLocation, SchemaType.Mapped, "véhicules");
            db.Fill(dsMultiLocation, "véhicules");

            db = new MySqlDataAdapter("sp_SelectTermes", connexion);
            db.SelectCommand.CommandType = CommandType.StoredProcedure;
            db.FillSchema(dsMultiLocation, SchemaType.Mapped, "termes");
            db.Fill(dsMultiLocation, "termes");

            db = new MySqlDataAdapter("sp_SelectPaiements", connexion);
            db.SelectCommand.CommandType = CommandType.StoredProcedure;
            db.FillSchema(dsMultiLocation, SchemaType.Mapped, "paiements");
            db.Fill(dsMultiLocation, "paiements");

            ListeClients.ItemsSource = dsMultiLocation.Tables["clients"].DefaultView;
            ListeVehicules.ItemsSource = dsMultiLocation.Tables["véhicules"].DefaultView;
            
        }

        private void VerifierInfo(object sender, TextChangedEventArgs e)
        {
            if (editMode)
            {
                if (!infoTexte)
                {
                    if (!string.IsNullOrEmpty(txtIdLocation.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtPaiementMensuel.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtKilometrageInitial.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtIdTermes.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtNombreAnnees.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtKilometrageMax.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtTauxSurprime.Text.Trim()) &&
                        txtDateLocation.SelectedDate.HasValue &&
                        txtDatePremierPaiement.SelectedDate.HasValue &&
                        ListeClients.SelectedIndex != -1 &&
                        ListeVehicules.SelectedIndex != -1)
                    {
                        infoTexte = true;
                    }   
                }
                else
                {
                }
                    
                    if (selection)
                    {
                        btnEnregistrer.IsEnabled = true;
                    }
            }
        }

        private void VerifierSelection(object sender, SelectionChangedEventArgs e)
        {
            if (editMode)
            {
               if (txtDateLocation.SelectedDate.HasValue &&
                   txtDatePremierPaiement.SelectedDate.HasValue &&
                   ListeClients.SelectedIndex != -1 &&
                   ListeVehicules.SelectedIndex != -1)
                {
                    selection = true;
                    if (infoTexte)
                    {
                        btnEnregistrer.IsEnabled = true;
                    }
                }
            }
        }

        private void btnNouveau_Click(object sender, RoutedEventArgs e)
        {

            DataTable tbLocation = dsMultiLocation.Tables["locations"];
            DataTable tbTerme = dsMultiLocation.Tables["termes"];
          //  foreach (DataRow row in tbLocation.Rows)


            int idLocation = tbLocation.Rows.Count + 1;
            int idTerme = tbTerme.Rows.Count + 1;
            nouveau = true;
            SwitchEditMode();
            editMode = true;
            Reset();
            txtIdLocation.Text = idLocation.ToString();
            txtIdTermes.Text = idTerme.ToString();

        }
        private void btnAnnuler_Click(object sender, RoutedEventArgs e)
        {
            SwitchEditMode();
            editMode = false;
            Reset();
            nouveau = false;
        }

        private void Reset()
        {
            if (nouveau)
            {
                txtIdTermes.Text = txtIdLocation.Text = SearchLocations.Text = string.Empty;

                txtNombreAnnees.Text = txtNombrePaiement.Text = txtDateLocation.Text = txtDatePremierPaiement.Text = txtPaiementMensuel.Text = txtKilometrageInitial.Text = txtKilometrageFinal.Text = txtKilometrageMax.Text = txtTauxSurprime.Text = string.Empty;
                
                isNouveauVehicule.IsChecked = false;
                ListeClients.SelectedIndex = -1;
                ListeVehicules.SelectedIndex = -1;
                
                txtIdClient.Text = txtPrenom.Text = txtNom.Text = txtTelephone.Text = txtAdresse.Text = txtVille.Text = txtProvince.Text = txtCodePostal.Text = string.Empty;

                rbActif.IsChecked = false;
                rbPause.IsChecked = false;
                rbFerme.IsChecked = false;
                statut = -1;
            } 
            else
            {
                FindLocationInfos();
            }
        }

        private void FindLocationInfos()
        {
            try
            {

                location = dsMultiLocation.Tables["locations"].Rows.Find(SearchLocations.Text.ToString());
                
                
                client = dsMultiLocation.Tables["clients"].Rows.Find(location["Clients_id"].ToString());
                vehicule = dsMultiLocation.Tables["véhicules"].Rows.Find(location["Véhicules_NIV"].ToString());
                terme = dsMultiLocation.Tables["termes"].Rows.Find(location["Termes_Location_id"].ToString());
                btnModifier.IsEnabled = true;


                txtIdLocation.Text = location["IdLocation"].ToString();
                ListeClients.SelectedValue = location["Clients_id"];
                txtDateLocation.Text = location["DateLocation"].ToString();
                txtDatePremierPaiement.Text = location["DatePremierPaiement"].ToString();
                txtPaiementMensuel.Text = location["PaiementMensuel"].ToString();
                txtNombrePaiement.Text = location["NombrePaiement"].ToString();
                ListeVehicules.SelectedValue = location["Véhicules_NIV"].ToString();
                txtKilometrageInitial.Text = location["KilometrageInitial"].ToString();
                txtKilometrageFinal.Text = location["KilometrageFinal"].ToString();
                txtKilometrageMax.Text = terme["KilometrageMax"].ToString();
                txtIdTermes.Text = location["Termes_Location_id"].ToString();
                txtNombreAnnees.Text = terme["NombreAnnees"].ToString();
                txtTauxSurprime.Text = terme["TauxSurprime"].ToString();

                switch (Convert.ToInt16(location["Statut"]))
                {
                    case -1:
                        rbActif.IsChecked = false;
                        rbPause.IsChecked = false;
                        rbFerme.IsChecked = false;
                        break;
                    case 0:
                        rbActif.IsChecked = true;
                        break;
                    case 1:
                        rbPause.IsChecked = true;
                        break;
                    case 2:
                        rbFerme.IsChecked = true;
                        break;
                }

                txtIdClient.Text = client["id"].ToString();
                txtPrenom.Text = client["Prenom"].ToString();
                txtNom.Text = client["Nom"].ToString();
                txtTelephone.Text = client["Telephone"].ToString();
                txtAdresse.Text = client["Adresse"].ToString();
                txtVille.Text = client["Ville"].ToString();
                txtProvince.Text = client["Province"].ToString();
                txtCodePostal.Text = client["CodePostal"].ToString();
            } 
            catch (Exception)
            {
                MessageBox.Show("Aucun résultat trouvée.");
            }
        }

        private void EnregistrerLocation()
        {
            string requete = "";
            if (nouveau)
            {
                requete = "sp_InsertLocation";
            }
            else
            {
                requete = "sp_UpdateLocation";
            }
            try
            {
                db = new MySqlDataAdapter();
                MySqlCommand commande = new MySqlCommand(requete, connexion);
                commande.CommandType = CommandType.StoredProcedure;
                commande.Parameters.AddWithValue("@p_IdLocation", txtIdLocation.Text);
                commande.Parameters.AddWithValue("@p_DateLocation", location["DateLocation"]);
                commande.Parameters.AddWithValue("@p_DatePremierPaiement", location["DatePremierPaiement"]);
                commande.Parameters.AddWithValue("@p_PaiementMensuel", location["PaiementMensuel"]);
                commande.Parameters.AddWithValue("@p_NombrePaiement", location["NombrePaiement"]);
                commande.Parameters.AddWithValue("@p_NouveauVehicule", location["NouveauVehicule"]);
                commande.Parameters.AddWithValue("@p_Clients_id", location["Clients_id"]);
                commande.Parameters.AddWithValue("@p_KilometrageInitial", location["KilometrageInitial"]);
                commande.Parameters.AddWithValue("@p_KilometrageFinal", location["KilometrageFinal"]); 
                commande.Parameters.AddWithValue("@p_Véhicules_NIV", location["Véhicules_NIV"]);
                commande.Parameters.AddWithValue("@p_Termes_Location_id", txtIdTermes.Text);
                commande.Parameters.AddWithValue("@p_Statut", location["Statut"]);
                commande.Parameters.AddWithValue("@p_NombreAnnees", terme["NombreAnnees"]);
                commande.Parameters.AddWithValue("@p_KilometrageMax", terme["KilometrageMax"]);
                commande.Parameters.AddWithValue("@p_TauxSurprime", terme["TauxSurprime"]);

                db.InsertCommand = commande;
                connexion.Open();
                db.InsertCommand.ExecuteNonQuery();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message, "Erreur", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                connexion.Close();
            }
        }

        private void btnEnregistrer_Click(object sender, RoutedEventArgs e)
        {
            if (!string.IsNullOrEmpty(txtIdLocation.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtPaiementMensuel.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtKilometrageInitial.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtIdTermes.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtNombreAnnees.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtKilometrageMax.Text.Trim()) &&
                        !string.IsNullOrEmpty(txtTauxSurprime.Text.Trim()) &&
                        txtDateLocation.SelectedDate.HasValue &&
                        txtDatePremierPaiement.SelectedDate.HasValue &&
                        ListeClients.SelectedIndex != -1 &&
                        ListeVehicules.SelectedIndex != -1)
            {
                string message = "Ajouter le contrat de location";
                string caption = "Confirmation";
                MessageBoxResult result = MessageBox.Show(message, caption, MessageBoxButton.YesNo, MessageBoxImage.Question);
                if (result == MessageBoxResult.Yes)
            {
                if (nouveau)
                {
                    try
                    {
                        int idTerme = dsMultiLocation.Tables["termes"].Rows.Count + 1;
                        int idLocation = dsMultiLocation.Tables["locations"].Rows.Count + 1;

                        terme = dsMultiLocation.Tables["termes"].NewRow();
                        terme["id"] = txtIdTermes.Text;
                        terme["NombreAnnees"] = txtNombreAnnees.Text;
                        terme["KilometrageMax"] = txtKilometrageMax.Text;
                        terme["TauxSurprime"] = txtTauxSurprime.Text;
                        dsMultiLocation.Tables["termes"].Rows.Add(terme);

                        location = dsMultiLocation.Tables["locations"].NewRow();
                        location["IdLocation"] = txtIdLocation.Text;
                        location["Clients_id"] = ListeClients.SelectedValue;
                        location["DateLocation"] = txtDateLocation.SelectedDate;
                        location["DatePremierPaiement"] = txtDatePremierPaiement.SelectedDate;
                        location["PaiementMensuel"] = txtPaiementMensuel.Text;
                        location["NombrePaiement"] = txtNombrePaiement.Text;
                        location["Véhicules_NIV"] = ListeVehicules.SelectedValue;
                        location["KilometrageInitial"] = txtKilometrageInitial.Text;
                        location["KilometrageFinal"] = 0;
                        location["NouveauVehicule"] = isNouveauVehicule.IsChecked;
                        location["Termes_Location_id"] = txtIdTermes.Text;
                        location["Statut"] = statut;
                        dsMultiLocation.Tables["locations"].Rows.Add(location);
                        EnregistrerLocation();
                        Reset();
                        nouveau = false;
                        SwitchEditMode();
                        editMode = false;
                        MessageBox.Show("Ajout du nouveau contrat de location réussi.", "Enregistrement", MessageBoxButton.OK, MessageBoxImage.Information);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message, "Erreur", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
                else
                {
                    try
                    {
                    terme["NombreAnnees"] = txtNombreAnnees.Text;
                    terme["KilometrageMax"] = txtKilometrageMax.Text;
                    terme["TauxSurprime"] = txtTauxSurprime.Text;

                    location["IdLocation"] = txtIdLocation.Text;
                    location["Clients_id"] = ListeClients.SelectedValue;
                    location["DateLocation"] = txtDateLocation.SelectedDate;
                    location["DatePremierPaiement"] = txtDatePremierPaiement.SelectedDate;
                    location["PaiementMensuel"] = txtPaiementMensuel.Text;
                    location["NombrePaiement"] = txtNombrePaiement.Text;
                    location["Véhicules_NIV"] = ListeVehicules.SelectedValue;
                    location["KilometrageInitial"] = txtKilometrageInitial.Text;
                    location["KilometrageFinal"] = txtKilometrageFinal.Text;
                    location["NouveauVehicule"] = isNouveauVehicule.IsChecked;
                    location["Termes_Location_id"] = txtIdTermes.Text;
                    location["Statut"] = statut;

                    EnregistrerLocation();
                    Reset();
                    SwitchEditMode();
                    editMode = false;
                    MessageBox.Show("Modification des informations effectuée.", "Modification", MessageBoxButton.OK, MessageBoxImage.Information);
                
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message, "Erreur", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
            }
            }
        }

        private void SwitchEditMode()
        {
            if (!editMode)
            {
                SearchLocations.IsReadOnly = true;
                ListeClients.IsEnabled = true;
                txtDateLocation.IsEnabled = true;
                txtDatePremierPaiement.IsEnabled = true;
                txtPaiementMensuel.IsReadOnly = false;
                txtNombrePaiement.IsReadOnly = false;
                txtKilometrageInitial.IsReadOnly = false;
                txtKilometrageFinal.IsReadOnly = false;
                ListeVehicules.IsEnabled = true;
                txtNombreAnnees.IsReadOnly = false;
                txtKilometrageMax.IsReadOnly = false;
                txtTauxSurprime.IsReadOnly = false;
                rbActif.IsEnabled = true;
                rbPause.IsEnabled = true;
                rbFerme.IsEnabled = true;
                btnNouveau.IsEnabled = false;
                btnAnnuler.IsEnabled = true;
                btnEnregistrer.IsEnabled = false;
                btnModifier.IsEnabled = false;
                btnRechercher.IsEnabled = false;
            }
            else
            {
                txtIdLocation.IsReadOnly = true;
                txtIdTermes.IsReadOnly = true;
                SearchLocations.IsReadOnly = false;
                ListeClients.IsEnabled = false;
                txtDateLocation.IsEnabled = false;
                txtDatePremierPaiement.IsEnabled = false;
                txtPaiementMensuel.IsReadOnly = true;
                txtNombrePaiement.IsReadOnly = true;
                txtKilometrageInitial.IsReadOnly = true;
                txtKilometrageFinal.IsReadOnly = true;
                ListeVehicules.IsEnabled = false;
                txtNombreAnnees.IsReadOnly = true;
                txtKilometrageMax.IsReadOnly = true;
                txtTauxSurprime.IsReadOnly = true;
                rbActif.IsEnabled = false;
                rbPause.IsEnabled = false;
                rbFerme.IsEnabled = false;
                btnNouveau.IsEnabled = true;
                btnAnnuler.IsEnabled = false;
                btnEnregistrer.IsEnabled = false;
                btnModifier.IsEnabled = true;
                btnRechercher.IsEnabled = true;

            }

        }

        private void rbActif_Checked(object sender, RoutedEventArgs e)
        {
            if (nouveau)
            {
                statut = 0;
            }
        }
        private void rbPause_Checked(object sender, RoutedEventArgs e)
        {
            if (nouveau)
            {
                statut = 1;
            }
        }
        private void rbFerme_Checked(object sender, RoutedEventArgs e)
        {
            if (nouveau)
            {
                statut = 2;
            }
        }

        private void btnModifier_Click(object sender, RoutedEventArgs e)
        {
            SwitchEditMode();
            editMode = true;
        }

        private void btnRechercher_Click(object sender, RoutedEventArgs e)
        {
            FindLocationInfos();
        }

        private void txtIdClient_Change(object sender, TextChangedEventArgs e)
        {

        }

        private void VerifierKmFinal(object sender, TextChangedEventArgs e)
        {

        }
    }
}
