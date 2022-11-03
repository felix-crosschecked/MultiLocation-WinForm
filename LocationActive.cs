using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MultiLocation
{
    public class LocationActive
    {
        public string IdLocation { get; set; }
        public string Clients_id { get; set; }
        public string DateLocation { get; set; }
        public string DatePremierPaiement { get; set; }
        public string PaiementMensuel { get; set; }
        public string NombrePaiement { get; set; }
        public string Véhicules_NIV { get; set; }
        public string Termes_Location_id { get; set; }
        public string Statut_Active { get; set; }
        public string Transactions { get; set; }
        public string NouveauVehicule { get; set; }
        public string KilometrageInitial { get; set; }
        public string KilometrageFinal { get; set; }
    }
}
