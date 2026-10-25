import json, subprocess
d=json.load(open('resultados-sonnet-5-5.json'))
Q={"explicacao":"Qual a diferença entre git merge e git rebase?","codigo":"Função Python que soma gastos por categoria de um CSV.","erro":"ModuleNotFoundError requests no Windows.","abnt":"Citação longa ABNT no TCC."}
hist="".join(f"\n\nUSUÁRIO: {Q[k]}\nCLAUDE: {d[k+'|normal'][0]['text']}{chr(10)}USUÁRIO: e mais detalhes?{chr(10)}CLAUDE: {d[k+'|normal'][1]['text']}" for k in Q)
def run(p):
    r=subprocess.run(["claude","-p",p,"--output-format","json","--model","claude-sonnet-5-5","--tools",""],capture_output=True,text=True,timeout=300)
    j=json.loads(r.stdout);u=j["usage"]
    return u["input_tokens"]+u["cache_creation_input_tokens"]+u["cache_read_input_tokens"],u["output_tokens"],j["total_cost_usd"],j["result"]
FOLLOW="\n\nAgora: adapte a função do CSV para ignorar linhas com valor vazio."
full=run("Histórico da nossa conversa:"+hist+FOLLOW)
summ=run("Histórico da nossa conversa:"+hist+"\n\nResuma esta conversa para eu continuar em outra, em até 15 linhas:\nObjetivo | Decidido | Feito | Falta fazer | Arquivos envolvidos | Cuidados/erros já vistos.\nSem explicações, só fatos.")
resumo=summ[3]
cont=run("Continuação. Contexto abaixo; não repita, só siga do \"Falta fazer\".\n"+resumo+FOLLOW)
print("baseline sem histórico ~16.3k (prompt do sistema)")
print("com historico completo: in",full[0],"out",full[1],"custo",round(full[2],4))
print("gerar resumo (1x): in",summ[0],"out",summ[1],"custo",round(summ[2],4))
print("com resumo: in",cont[0],"out",cont[1],"custo",round(cont[2],4))
print("RESUMO:\n",resumo)
print("RESPOSTA COM RESUMO:\n",cont[3][:600])
