import json, subprocess, statistics, sys
ECO = """Modo econômico até eu dizer o contrário:
- Responda curto e direto. Sem saudação, elogio, resumo do que eu disse ou conclusão repetida.
- Frases curtas; fragmentos ok. Sem rodeios nem "talvez/acho que" desnecessários.
- Termos técnicos exatos. Código só o trecho alterado, não o arquivo inteiro.
- Estrutura: causa → ação → próximo passo.
- Não leia arquivos nem rode comandos além do necessário; pergunte se faltar informação.
- Se a tarefa for grande, mostre o plano em até 5 linhas antes de executar.

"""
TASKS = {
 "explicacao": "Qual a diferença entre git merge e git rebase e quando usar cada um?",
 "codigo": "Escreva uma função Python que lê um CSV de gastos (colunas data,categoria,valor) e retorna o total por categoria. Depois explique como usar.",
 "erro": "Meu script Python dá 'ModuleNotFoundError: No module named requests' no Windows. Como resolvo?",
 "abnt": "Como formatar citação direta longa (mais de 3 linhas) nas normas ABNT no TCC?",
}
MODEL = sys.argv[1] if len(sys.argv)>1 else "claude-sonnet-5-5"
REPS = 2
def run(prompt):
    r = subprocess.run(["claude","-p",prompt,"--output-format","json","--model",MODEL,"--tools",""],capture_output=True,text=True,timeout=300)
    d = json.loads(r.stdout)
    u = d["usage"]
    return dict(out=u["output_tokens"], inp=u["input_tokens"]+u["cache_creation_input_tokens"]+u["cache_read_input_tokens"], cost=d["total_cost_usd"], text=d.get("result",""))
res = {}
for k,t in TASKS.items():
    for mode,p in (("normal",t),("eco",ECO+t)):
        res[(k,mode)] = [run(p) for _ in range(REPS)]
        print(k,mode,[x["out"] for x in res[(k,mode)]],flush=True)
json.dump({f"{k}|{m}":v for (k,m),v in res.items()}, open(f"resultados-{MODEL.replace('claude-','')}.json","w"), ensure_ascii=False, indent=1)
