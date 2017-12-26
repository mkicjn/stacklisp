.data
dict_type_str:
	.string	"type"
dict_type_sym:
	.quad	1,dict_type_str
dict_type_var:
	.quad	3,type
dict_type_cell:
	.quad	0,dict_type_sym,dict_type_var
dict_type_def:
	.quad	0,dict_type_cell,NIL
dict_terpri_str:
	.string	"terpri"
dict_terpri_sym:
	.quad	1,dict_terpri_str
dict_terpri_var:
	.quad	3,terpri
dict_terpri_cell:
	.quad	0,dict_terpri_sym,dict_terpri_var
dict_terpri_def:
	.quad	0,dict_terpri_cell,dict_type_def
dict_set_str:
	.string	"set"
dict_set_sym:
	.quad	1,dict_set_str
dict_set_var:
	.quad	3,set
dict_set_cell:
	.quad	0,dict_set_sym,dict_set_var
dict_set_def:
	.quad	0,dict_set_cell,dict_terpri_def
dict_rplacd_str:
	.string	"rplacd"
dict_rplacd_sym:
	.quad	1,dict_rplacd_str
dict_rplacd_var:
	.quad	3,rplacd
dict_rplacd_cell:
	.quad	0,dict_rplacd_sym,dict_rplacd_var
dict_rplacd_def:
	.quad	0,dict_rplacd_cell,dict_set_def
dict_rplaca_str:
	.string	"rplaca"
dict_rplaca_sym:
	.quad	1,dict_rplaca_str
dict_rplaca_var:
	.quad	3,rplaca
dict_rplaca_cell:
	.quad	0,dict_rplaca_sym,dict_rplaca_var
dict_rplaca_def:
	.quad	0,dict_rplaca_cell,dict_rplacd_def
dict_reference_str:
	.string	"reference"
dict_reference_sym:
	.quad	1,dict_reference_str
dict_reference_var:
	.quad	3,reference
dict_reference_cell:
	.quad	0,dict_reference_sym,dict_reference_var
dict_reference_def:
	.quad	0,dict_reference_cell,dict_rplaca_def
dict_lread_str:
	.string	"lread"
dict_lread_sym:
	.quad	1,dict_lread_str
dict_lread_var:
	.quad	3,lread
dict_lread_cell:
	.quad	0,dict_lread_sym,dict_lread_var
dict_lread_def:
	.quad	0,dict_lread_cell,dict_reference_def
dict_nconc_str:
	.string	"nconc"
dict_nconc_sym:
	.quad	1,dict_nconc_str
dict_nconc_var:
	.quad	3,nconc
dict_nconc_cell:
	.quad	0,dict_nconc_sym,dict_nconc_var
dict_nconc_def:
	.quad	0,dict_nconc_cell,dict_lread_def
dict_list_str:
	.string	"list"
dict_list_sym:
	.quad	1,dict_list_str
dict_list_var:
	.quad	3,list
dict_list_cell:
	.quad	0,dict_list_sym,dict_list_var
dict_list_def:
	.quad	0,dict_list_cell,dict_nconc_def
dict_funcall_str:
	.string	"funcall"
dict_funcall_sym:
	.quad	1,dict_funcall_str
dict_funcall_var:
	.quad	3,funcall
dict_funcall_cell:
	.quad	0,dict_funcall_sym,dict_funcall_var
dict_funcall_def:
	.quad	0,dict_funcall_cell,dict_list_def
dict_eq_str:
	.string	"eq"
dict_eq_sym:
	.quad	1,dict_eq_str
dict_eq_var:
	.quad	3,eq
dict_eq_cell:
	.quad	0,dict_eq_sym,dict_eq_var
dict_eq_def:
	.quad	0,dict_eq_cell,dict_funcall_def
dict_disp_str:
	.string	"disp"
dict_disp_sym:
	.quad	1,dict_disp_str
dict_disp_var:
	.quad	3,disp
dict_disp_cell:
	.quad	0,dict_disp_sym,dict_disp_var
dict_disp_def:
	.quad	0,dict_disp_cell,dict_eq_def
dict_define_str:
	.string	"define"
dict_define_sym:
	.quad	1,dict_define_str
dict_define_var:
	.quad	3,define
dict_define_cell:
	.quad	0,dict_define_sym,dict_define_var
dict_define_def:
	.quad	0,dict_define_cell,dict_disp_def
dict_copy_str:
	.string	"copy"
dict_copy_sym:
	.quad	1,dict_copy_str
dict_copy_var:
	.quad	3,copy
dict_copy_cell:
	.quad	0,dict_copy_sym,dict_copy_var
dict_copy_def:
	.quad	0,dict_copy_cell,dict_define_def
dict_cons_str:
	.string	"cons"
dict_cons_sym:
	.quad	1,dict_cons_str
dict_cons_var:
	.quad	3,cons
dict_cons_cell:
	.quad	0,dict_cons_sym,dict_cons_var
dict_cons_def:
	.quad	0,dict_cons_cell,dict_copy_def
dict_cdr_str:
	.string	"cdr"
dict_cdr_sym:
	.quad	1,dict_cdr_str
dict_cdr_var:
	.quad	3,cdr
dict_cdr_cell:
	.quad	0,dict_cdr_sym,dict_cdr_var
dict_cdr_def:
	.quad	0,dict_cdr_cell,dict_cons_def
dict_car_str:
	.string	"car"
dict_car_sym:
	.quad	1,dict_car_str
dict_car_var:
	.quad	3,car
dict_car_cell:
	.quad	0,dict_car_sym,dict_car_var
dict_car_def:
	.quad	0,dict_car_cell,dict_cdr_def
dict_atom_str:
	.string	"atom"
dict_atom_sym:
	.quad	1,dict_atom_str
dict_atom_var:
	.quad	3,atom
dict_atom_cell:
	.quad	0,dict_atom_sym,dict_atom_var
dict_atom_def:
	.quad	0,dict_atom_cell,dict_car_def
dict_append_str:
	.string	"append"
dict_append_sym:
	.quad	1,dict_append_str
dict_append_var:
	.quad	3,append
dict_append_cell:
	.quad	0,dict_append_sym,dict_append_var
DICT:
	.quad	0,dict_append_cell,dict_atom_def
.text
