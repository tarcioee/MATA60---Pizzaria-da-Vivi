import os
import subprocess
from datetime import datetime
import time
from dotenv import load_dotenv

# Carregar variáveis de ambiente
load_dotenv()

# Dados de conexão com o banco de dados
db_host = os.environ.get('DB_HOST')
db_port = os.environ.get('DB_PORT')
db_name = os.environ.get('DB_NAME')
db_user = os.environ.get('DB_USER')
db_password = os.environ.get('DB_PASSWORD')
bk_dir_local = os.environ.get('DIR_LOCAL')

# Função para realizar o backup
def realizar_backup(database, usuario, senha, host='localhost', porta=5432, diretorio_backup='./backups'):
    
    # Cria o diretório de backups se não existir
    os.makedirs(diretorio_backup, exist_ok=True)
    
    # Gera o nome do arquivo de backup com data e hora
    data_hora = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    nome_arquivo = f"full_backup_{data_hora}.dump"
    caminho_completo = os.path.join(diretorio_backup, nome_arquivo)
    
    # Comando para realizar o backup
    comando = f"PGPASSWORD={senha} pg_dump -h {host} -p {porta} -U {usuario} -Fc {database} -f {caminho_completo}"
    
    try:
        # Executa o comando e captura a saída
        resultado = subprocess.run(comando, shell=True, capture_output=True, text=True)
        
        if resultado.returncode == 0:
            print(f"Backup realizado com sucesso em: {caminho_completo}")
        else:
            print(f"Erro ao realizar o backup: {resultado.stderr}")
    
        # Limpeza: Remover backups antigos (mais de 7 dias)
        for arquivo in os.listdir(diretorio_backup):
            if arquivo.endswith(".dump"):
                caminho_arquivo = os.path.join(diretorio_backup, arquivo)
                if os.path.getmtime(caminho_arquivo) < time.time() - (7 * 24 * 60 * 60):  # 7 dias em segundos
                    os.remove(caminho_arquivo)
                    print(f"Backup antigo removido: {caminho_arquivo}")
    
    except subprocess.CalledProcessError as e:
        print(f"Erro ao executar o comando: {e}")
    
# Exemplo de uso do script com as variáveis carregadas
if __name__ == "__main__":
    realizar_backup(db_name, db_user, db_password, db_host, db_port, bk_dir_local)
