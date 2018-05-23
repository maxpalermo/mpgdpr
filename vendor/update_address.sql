update ps_address set type = 'delivery' where vat_number='' and dni='';
update ps_address set type = 'delivery' where vat_number='' and dni!='';
update ps_address set type = 'invoice' where vat_number!='' and dni='';
update ps_address set type = 'invoice' where vat_number!='' and dni!='';