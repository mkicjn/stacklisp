.data
dict_type_str:
	.string	"TYPE"
dict_type_sym:
	.quad	1,dict_type_str
dict_type_var:
	.quad	3,type
dict_type_cell:
	.quad	0,dict_type_sym,dict_type_var
dict_type_def:
	.quad	0,dict_type_cell,NIL
dict_terpri_str:
	.string	"TERPRI"
dict_terpri_sym:
	.quad	1,dict_terpri_str
dict_terpri_var:
	.quad	3,terpri
dict_terpri_cell:
	.quad	0,dict_terpri_sym,dict_terpri_var
dict_terpri_def:
	.quad	0,dict_terpri_cell,dict_type_def
dict_symbol_value_str:
	.string	"SYMBOL_VALUE"
dict_symbol_value_sym:
	.quad	1,dict_symbol_value_str
dict_symbol_value_var:
	.quad	3,symbol_value
dict_symbol_value_cell:
	.quad	0,dict_symbol_value_sym,dict_symbol_value_var
dict_symbol_value_def:
	.quad	0,dict_symbol_value_cell,dict_terpri_def
dict_set_str:
	.string	"SET"
dict_set_sym:
	.quad	1,dict_set_str
dict_set_var:
	.quad	3,set
dict_set_cell:
	.quad	0,dict_set_sym,dict_set_var
dict_set_def:
	.quad	0,dict_set_cell,dict_symbol_value_def
dict_rplacd_str:
	.string	"RPLACD"
dict_rplacd_sym:
	.quad	1,dict_rplacd_str
dict_rplacd_var:
	.quad	3,rplacd
dict_rplacd_cell:
	.quad	0,dict_rplacd_sym,dict_rplacd_var
dict_rplacd_def:
	.quad	0,dict_rplacd_cell,dict_set_def
dict_rplaca_str:
	.string	"RPLACA"
dict_rplaca_sym:
	.quad	1,dict_rplaca_str
dict_rplaca_var:
	.quad	3,rplaca
dict_rplaca_cell:
	.quad	0,dict_rplaca_sym,dict_rplaca_var
dict_rplaca_def:
	.quad	0,dict_rplaca_cell,dict_rplacd_def
dict_return_str:
	.string	"RETURN"
dict_return_sym:
	.quad	1,dict_return_str
dict_return_var:
	.quad	6,return
dict_return_cell:
	.quad	0,dict_return_sym,dict_return_var
dict_return_def:
	.quad	0,dict_return_cell,dict_rplaca_def
dict_read_str:
	.string	"READ"
dict_read_sym:
	.quad	1,dict_read_str
dict_read_var:
	.quad	3,lread
dict_read_cell:
	.quad	0,dict_read_sym,dict_read_var
dict_read_def:
	.quad	0,dict_read_cell,dict_return_def
dict_quote_str:
	.string	"QUOTE"
dict_quote_sym:
	.quad	1,dict_quote_str
dict_quote_var:
	.quad	6,quote
dict_quote_cell:
	.quad	0,dict_quote_sym,dict_quote_var
dict_quote_def:
	.quad	0,dict_quote_cell,dict_read_def
dict_progn_str:
	.string	"PROGN"
dict_progn_sym:
	.quad	1,dict_progn_str
dict_progn_var:
	.quad	6,progn
dict_progn_cell:
	.quad	0,dict_progn_sym,dict_progn_var
dict_progn_def:
	.quad	0,dict_progn_cell,dict_quote_def
dict_nconc_str:
	.string	"NCONC"
dict_nconc_sym:
	.quad	1,dict_nconc_str
dict_nconc_var:
	.quad	3,nconc
dict_nconc_cell:
	.quad	0,dict_nconc_sym,dict_nconc_var
dict_nconc_def:
	.quad	0,dict_nconc_cell,dict_progn_def
dict_list_str:
	.string	"LIST"
dict_list_sym:
	.quad	1,dict_list_str
dict_list_var:
	.quad	4,list
dict_list_cell:
	.quad	0,dict_list_sym,dict_list_var
dict_list_def:
	.quad	0,dict_list_cell,dict_nconc_def
dict_length_str:
	.string	"LENGTH"
dict_length_sym:
	.quad	1,dict_length_str
dict_length_var:
	.quad	3,length
dict_length_cell:
	.quad	0,dict_length_sym,dict_length_var
dict_length_def:
	.quad	0,dict_length_cell,dict_list_def
dict_lambda_str:
	.string	"LAMBDA"
dict_lambda_sym:
	.quad	1,dict_lambda_str
dict_lambda_var:
	.quad	3,lambda
dict_lambda_cell:
	.quad	0,dict_lambda_sym,dict_lambda_var
dict_lambda_def:
	.quad	0,dict_lambda_cell,dict_length_def
dict_funcall_str:
	.string	"FUNCALL"
dict_funcall_sym:
	.quad	1,dict_funcall_str
dict_funcall_var:
	.quad	3,funcall
dict_funcall_cell:
	.quad	0,dict_funcall_sym,dict_funcall_var
dict_funcall_def:
	.quad	0,dict_funcall_cell,dict_lambda_def
dict_eq_str:
	.string	"EQ"
dict_eq_sym:
	.quad	1,dict_eq_str
dict_eq_var:
	.quad	3,eq
dict_eq_cell:
	.quad	0,dict_eq_sym,dict_eq_var
dict_eq_def:
	.quad	0,dict_eq_cell,dict_funcall_def
dict_disp_str:
	.string	"DISP"
dict_disp_sym:
	.quad	1,dict_disp_str
dict_disp_var:
	.quad	3,disp
dict_disp_cell:
	.quad	0,dict_disp_sym,dict_disp_var
dict_disp_def:
	.quad	0,dict_disp_cell,dict_eq_def
dict_define_str:
	.string	"DEFINE"
dict_define_sym:
	.quad	1,dict_define_str
dict_define_var:
	.quad	3,define
dict_define_cell:
	.quad	0,dict_define_sym,dict_define_var
dict_define_def:
	.quad	0,dict_define_cell,dict_disp_def
dict_copy_str:
	.string	"COPY"
dict_copy_sym:
	.quad	1,dict_copy_str
dict_copy_var:
	.quad	3,copy
dict_copy_cell:
	.quad	0,dict_copy_sym,dict_copy_var
dict_copy_def:
	.quad	0,dict_copy_cell,dict_define_def
dict_cons_str:
	.string	"CONS"
dict_cons_sym:
	.quad	1,dict_cons_str
dict_cons_var:
	.quad	3,cons
dict_cons_cell:
	.quad	0,dict_cons_sym,dict_cons_var
dict_cons_def:
	.quad	0,dict_cons_cell,dict_copy_def
dict_cond_str:
	.string	"COND"
dict_cond_sym:
	.quad	1,dict_cond_str
dict_cond_var:
	.quad	6,cond
dict_cond_cell:
	.quad	0,dict_cond_sym,dict_cond_var
dict_cond_def:
	.quad	0,dict_cond_cell,dict_cons_def
dict_cdr_str:
	.string	"CDR"
dict_cdr_sym:
	.quad	1,dict_cdr_str
dict_cdr_var:
	.quad	3,cdr
dict_cdr_cell:
	.quad	0,dict_cdr_sym,dict_cdr_var
dict_cdr_def:
	.quad	0,dict_cdr_cell,dict_cond_def
dict_car_str:
	.string	"CAR"
dict_car_sym:
	.quad	1,dict_car_str
dict_car_var:
	.quad	3,car
dict_car_cell:
	.quad	0,dict_car_sym,dict_car_var
dict_car_def:
	.quad	0,dict_car_cell,dict_cdr_def
dict_atom_str:
	.string	"ATOM"
dict_atom_sym:
	.quad	1,dict_atom_str
dict_atom_var:
	.quad	3,atom
dict_atom_cell:
	.quad	0,dict_atom_sym,dict_atom_var
dict_atom_def:
	.quad	0,dict_atom_cell,dict_car_def
dict_append_str:
	.string	"APPEND"
dict_append_sym:
	.quad	1,dict_append_str
dict_append_var:
	.quad	3,append
dict_append_cell:
	.quad	0,dict_append_sym,dict_append_var
DICT:
	.quad	0,dict_append_cell,dict_atom_def
.text
