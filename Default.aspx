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
						cd_prontuario
					</th>
					<th>
						nm_paciente
					</th>
					<th>
						nascimento
					</th>
					<th>
						nr_quarto
					</th>
					<th>
						dt_internacao_data
					</th>
					<th>
						dt_internacao_hora
					</th>
					<th>
						nm_especialidade
					</th>
					<th>
						nm_medico
					</th>
					<th>
						dt_ultimo_evento_data
					</th>
					<th>
						dt_ultimo_evento_hora
					</th>
				
					<th>
						nm_origem
					</th>
					<th>
						nr_convenio
					</th>
					<th>
						in_sexo
					</th>
					<th>
						nr_idade
					</th>
					<th>
						sg_cid
					</th>
					<th>
						descricao_cid
					</th>
					<th>
						nm_unidade_funcional
					</th>
					<th>
						tempo
					</th>
					<th>
						vinculo
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
		
			dadosMes();
			
			
		}

		function dadosMes(dataIni, dataFim,tipoPesquisa) {
			
			jQuery.support.cors = true;
			$.ajax({
			async: false
				, url: '<%= ResolveUrl("http://10.48.21.64:5001/hspmsgh-api/censo/") %>'
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
											"<td>" + CheckNullReturnBlank(dt.cd_prontuario) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.nm_paciente) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.nascimento) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.nr_quarto) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.dt_internacao_data) + "</td>" +                                            
											"<td>" + CheckNullReturnBlank(dt.dt_internacao_hora) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.nm_especialidade) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.nm_medico) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.dt_ultimo_evento_data) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.dt_ultimo_evento_hora) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.nm_origem) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.nr_convenio) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.in_sexo) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.nr_idade) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.sg_cid) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.descricao_cid) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.nm_unidade_funcional) + "</td>" +
											"<td>" + CheckNullReturnBlankTempo(dt.tempo) + "</td>" +
											"<td>" + CheckNullReturnBlank(dt.vinculo )+ "</td>" +
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
		function CheckNullReturnBlankTempo(item) {
		    return item = (item == null) ? '' : item.replace(/day/gi, " ").replace(/s/gi, " ").replace(/00:00:00/gi, "0");
		}
		function CheckNullReturnBlank(item) {
		    return item = (item == null) ? '' : item ;
		}
	</script>
	
   </body>
</html>
