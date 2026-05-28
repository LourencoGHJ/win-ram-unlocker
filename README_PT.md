# 🚀 Universal RAM Unlocker & Optimizer (by CONNECT Labs)

[⬅️ Voltar ao Menu Principal](./README.md)

![Plataforma](https://img.shields.io/badge/Plataforma-Windows%2010%20%7C%2011-lightgrey.svg)
![Licença](https://img.shields.io/badge/Licen%C3%A7a-MIT-green.svg)

Um script batch multilíngue, leve e automatizado, projetado para corrigir o famoso bug do Windows onde quantidades massivas de memória física (RAM) são incorretamente alocadas como **"Reservada para Hardware"** ou ficam presas na **"Lista em Espera" (Standby List)**.

> 💡 **Nota do Criador (Gui - CONNECT):**
> *Eu criei e refinei esta ferramenta porque foi o que VERIDICAMENTE funcionou comigo. O meu Windows estava a bloquear a minha memória física, fazendo com que o PC arrancasse a consumir uns absurdos **23GB de RAM** do nada. Após aplicar este script, o meu consumo no arranque desceu imediatamente para uns limpos e normais **6GB**!*

---

## 📸 Antes & Depois (Evidência Visual)

Dentro da pasta `/screenshots`, podes ver as provas do diagnóstico:
* **Antes:** O Gestor de Tarefas do Windows a mostrar uma quantidade enorme de RAM bloqueada em "Reservada para Hardware" ou um cache do sistema completamente sobrecarregado.
* **Depois:** Memória total do sistema restaurada e totalmente disponível para jogos (Valorant, CS) e processos pesados.

---

## 🛠️ Guia de Restauração Passo a Passo

Para corrigir completamente a alocação de memória, segue estes passos pela ordem correta:

### Passo 1: Diagnóstico com o RAMMap
1. Abre a ferramenta **RAMMap** que baixaste diretamente da Microsoft Sysinternals.
2. Olha para o separador **Use Counts**.
3. Verifica as colunas **"Driver Locked"** e **"Standby"**. Se estes números forem invulgarmente altos, o kernel do teu Windows está a gerir mal a tua camada de hardware.

### Passo 2: Executar o Script Automatizado
1. Transfere o ficheiro `Otimizador_RAM.bat` deste repositório.
2. Clica com o botão direito no ficheiro e seleciona **"Executar como Administrador"** (Crucial, pois o script modifica variáveis de boot e chaves de registo do sistema).
3. Seleciona o teu idioma preferido: **[1] Português**.
4. Lê o aviso e escolhe a **Opção [1] Executar Diagnóstico e Desbloqueio Total**.
5. Quando o script pedir, digita `S` para **reiniciar o teu PC**.

### Passo 3: Verificar a Correção
Após reiniciar, abre o teu **Gestor de Tarefas** -> **Desempenho** -> **Memória**. Vais ver que a memória "Reservada para Hardware" desceu drasticamente, devolvendo-te a capacidade total da tua RAM.

---

## 🔍 O que este Script faz nos Bastidores?

Ao contrário de "limpadores de RAM" manhosos que apenas fecham processos ativos, esta ferramenta ataca as variáveis de raiz do sistema:
1. **Reset do BCDEdit:** Limpa truncagens ocultas e limites de memória máxima (`removememory` / `truncatememory`) configurados incorretamente no `msconfig`.
2. **Remapeamento de I/O no Registo:** Ajusta os valores de `ClearPageFileAtShutdown` e `LargeSystemCache` no kernel de gestão de memória para forçar a libertação do hardware nos ciclos do sistema.
3. **Flush do Cache & Explorer:** Fecha e reinicia com segurança o subsistema do Windows Explorer enquanto faz um flush total às tabelas de cache internas e ao DNS.
4. **Recolha Ativa de Lixo (Garbage Collection):** Executa um comando em segundo plano via PowerShell (`[System.GC]::Collect()`) para obrigar o SO a libertar páginas mortas de drivers de hardware que já não estão em uso.

---

## 🤝 Contribuições e Partilha

Se este script salvou a performance dos teus jogos ou o teu fluxo de trabalho:
* ⭐ Deixa uma **Star** neste repositório para que mais pessoas o encontrem.
* 🔄 Partilha o link com amigos que sofram de quebras de FPS no Discord ou fóruns de tecnologia.
