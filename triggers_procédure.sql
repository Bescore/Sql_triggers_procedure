
DELIMITER //

CREATE TRIGGER insert_commande BEFORE INSERT  ON commandes
 FOR EACH ROW
    BEGIN
        IF NEW.total IS NULL THEN
        SET NEW.total=0;
        END IF;
    END //

 /********2*********/

DELIMITER //

CREATE OR REPLACE TRIGGER verif_det
BEFORE UPDATE  ON details
 FOR EACH ROW
    BEGIN
        IF NEW.qte <= 0
            THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Quantité <= 0";
        END IF;  
    END //

/*************3**************/

DELIMITER //

CREATE OR REPLACE TRIGGER update_commande AFTER INSERT ON details 
 FOR EACH ROW
 BEGIN
 UPDATE commandes SET total=total+(NEW.qte*NEW.prix) WHERE commandes.id= new.id_commande ; 
     
 END //

/*************4**************/

CREATE OR REPLACE TRIGGER update_commande BEFORE INSERT ON details 
 FOR EACH ROW
  BEGIN
  DECLARE nVprix DECIMAL;
  IF new.prix_u is NULL
  THEN set new.prix_u= SELECT prix  from produits where produits.id=
 END If ADDupdate commande set total=total+(new.qte*new.prix_u) where commande.id=new.id_commande;
 END //





/*************5**************/

DELIMITER //

CREATE TRIGGER commejeveux BEFORE DELETE ON detail
FOR EACH ROW
BEGIN
    UPDATE COMMANDE SET total = total - (OLD.prix*OLD.qte) WHERE id = OLD.id_commande;
    END //
    

