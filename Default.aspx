<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Relatorio Internações SGH</title>
	<link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />

	<script src='<%= ResolveUrl("https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js") %>'
		type="text/javascript"></script>
		
	 <script src='<%= ResolveUrl("https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js") %>'
		type="text/javascript"></script>

<style type="text/css">
.table{
		width: 100%;
		white-space: nowrap;	
	}
</style>
	</head>
<body>
	<form id="form1" runat="server">
	<div class="container">    
	   
		<h2> Internações SGH</h2>
		
		 <div class="form-group col-sm-2">                      
		   <div id="um">
		   Data_Inicio    
			<asp:TextBox ID="dtIni" runat="server" class="form-control" Width="120px" ></asp:TextBox> 
		  </div>
		  
		 <div id="dois">
		  Data_Fim
			<asp:TextBox ID="dtFim" runat="server" class="form-control" Width="120px" ></asp:TextBox>   
		  </div>
		   
		   <div id="tres">
			   <asp:DropDownList ID="DdlPesquisa" runat="server">
				   <asp:ListItem Value="2">Internação</asp:ListItem>
				   <asp:ListItem Value="1">Alta</asp:ListItem>
			   </asp:DropDownList>
			   </div>
	   </div> 
	   
		<input id="Button2" runat="server" type="button" onclick="gerarTabela()" value="Buscar Internações"
			class="btn btn-success" />
		<button onclick="salvaPlanilha();" class="btn btn-success">
			Salva Planilha</button>
			<button onclick="reloadPage();" class="btn btn-success">
			Limpar</button>
	</div>
	<div class="clearfix">
		<table id="tdata1" runat="server" class="table">
			<thead class="thead-dark">
				<tr>
					<th>
						Prontuario
					</th>
					<th>
						Nome
					</th>
					<th>
						Sexo
					</th>
					<th>
						Idade
					</th>
					<th>
						Quarto
					</th>
					<th>
						Leito
					</th>
					<th>
						Ala
					</th>
					<th>
						Clínica
					</th>
					<th>
						Unidade Funcional
					</th>
					<th>
						Acomodação
					</th>
					<th>
						St Leito
					</th>
					<th>
						Data da Internação
					</th>
					<th>
						Data Entrada no Setor
					</th>
					<th>
						nm_especialidade
					</th>
					<th>
						nm_medico
					</th>
					<th>
						dt_ultimo_evento
					</th>
					<th>
						nm_origem
					</th>
					<th>
						sg_cid
					</th>
					<th>
						tx_observacao
					</th>
					<th>
						nr_convenio
					</th>
					<th>
						nr_plano
					</th>
					<th>
						nm_convenio_plano
					</th>
					<th>
						nr_crm_profissional
					</th>
					<th>
						nm_carater_internacao
					</th>
					<th>
						nm_origem_internacao
					</th>
					<th>
						nr_procedimento
					</th>
					<th>
						dt_alta_medica
					</th>
					<th>
						dt_saida_paciente
					</th>
					<th>
						dt_tipo_alta_medica
					</th>
				</tr>
			</thead>
			<tbody id="tdata">
			</tbody>
		</table>
	</div>
	</form>

	<script type="text/javascript">
		$("#dtIni, #dtFim").mask("00/00/0000");
		
	
		function formataData(data) {
			var d = data.value;
			var dia = d.substr(0, 2);
			var mes = d.substr(3, 2);
			var ano = d.substr(6, 4);
			var dataCompleta = ano + "-" + mes + "-" + dia;
			return dataCompleta;
		}
		
		function salvaPlanilha() {
			var htmlPlanilha = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name></x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>' + document.getElementById("tdata1").innerHTML + '</table></body></html>';

			var htmlBase64 = btoa(htmlPlanilha);
			var link = "data:application/vnd.ms-excel;base64," + htmlBase64;


			var hyperlink = document.createElement("a");
			hyperlink.download = "Arquivo.xls";
			hyperlink.href = link;
			hyperlink.style.display = 'none';

			document.body.appendChild(hyperlink);
			hyperlink.click();
			document.body.removeChild(hyperlink);
		}

			 //Teste jr
		function gerarTabela() {
			var dataIni = formataData(document.getElementById('<%=dtIni.ClientID %>'));
			var dataFim = formataData(document.getElementById('<%=dtFim.ClientID %>'));
			var tipoPesquisa = document.getElementById('<%=DdlPesquisa.ClientID%>');
			dadosMes(dataIni, dataFim, tipoPesquisa.value);
			
			
		}

		function dadosMes(dataIni, dataFim,tipoPesquisa) {
			var dIni = JSON.stringify(dataIni);
			var dFim = JSON.stringify(dataFim);
			var Tpesquisa = tipoPesquisa;
			console.log(Tpesquisa);
			
			jQuery.support.cors = true;
			$.ajax({
			async: false
				, url: '<%= ResolveUrl("http://10.48.21.64:5000/hspmsgh-api/internacoes?tipo='+ Tpesquisa +'&dt_inicio=' + dIni + '&dt_fim=' + dFim + '") %>'
				, crossDomain: true
				//, data: '{tipo : 1, dt_inicio: "2020-02-03", dt_fim: "2020-02-03"}'
				, type: 'GET'
				, contentType: 'application/json; charset=utf-8'
				, dataType: 'json'
				, success: function(data) {
					//var data = JSON.parse(data.d);
									console.log("passou");
									data.forEach(function(dt) {
										$("tbody").append("<tr>" +
											"<td>" + dt.cd_prontuario + "</td>" +
											"<td>" + dt.nm_paciente + "</td>" +
											"<td>" + dt.in_sexo + "</td>" +
											"<td>" + dt.nr_idade + "</td>" +
											"<td>" + dt.nr_quarto + "</td>" +                                            
											"<td>" + dt.nr_leito + "</td>" +
											"<td>" + dt.nm_ala + "</td>" +
											"<td>" + dt.nm_clinica + "</td>" +
											"<td>" + dt.nm_unidade_funcional + "</td>" +
											"<td>" + dt.nm_acomodacao + "</td>" +
											"<td>" + dt.st_leito + "</td>" +
											"<td>" + dt.dt_internacao + "</td>" +
											"<td>" + dt.dt_entrada_setor + "</td>" +
											"<td>" + dt.nm_especialidade + "</td>" +
											"<td>" + dt.nm_medico + "</td>" +
											"<td>" + dt.dt_ultimo_evento + "</td>" +
											"<td>" + dt.nm_origem + "</td>" +                                            
											"<td>" + dt.sg_cid + "</td>" +
											"<td>" + dt.tx_observacao + "</td>" +
											"<td>" + dt.nr_convenio + "</td>" +
											"<td>" + dt.nr_plano + "</td>" +
											"<td>" + dt.nm_convenio_plano + "</td>" +
											"<td>" + dt.nr_crm_profissional + "</td>" +
											"<td>" + dt.nm_carater_internacao + "</td>" +
											"<td>" + dt.nm_origem_internacao + "</td>" +
											"<td>" + dt.nr_procedimento + "</td>" +
											"<td>" + dt.dt_alta_medica + "</td>" +
											"<td>" + dt.dt_saida_paciente + "</td>" +
											"<td>" + dt.dc_tipo_alta_medica + "</td>" +
										 "</tr>"
										);

									});

								}
								, error: function(xhr, er) {
									console.log("deu erro");
									console.log(er);
									$("#lbMsg").html('<p> Erro ' + xhr.staus + ' - ' + xhr.statusText + ' - <br />Tipo de erro:  ' + er + '</p>');
								}
			});
		}

		function reloadPage() {
			window.location.reload()
		}
		
	</script>
	
   </body>
</html>
