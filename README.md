# Base docker compose project

O projeto poderá ser usado como base para a criação de projetos que usem docker.
A documentação está destinada a sistemas operacionais linux derivados do debian como o Ubuntu.

## Requisitos iniciais

### Baixar o projeto em sua máquina

    git clone git@github.com:nielsonsantana/django-docker-compose-base-project.git

Se não tiver o git instalado em sua máquina, instale com o comando:

    sudo apt-get install git

Para os primeiros passos no git e github acesse: https://balta.io/blog/git-github-primeiros-passos#requisitos


### Instalação do docker

Execute os seguintes comandos:

Atualiza repositório:

    sudo apt-get update

Instala dependências:

    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

Adiciona chave para comunicação com repositório do docker:

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

Adiciona repositório docker

    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

Atualiza repositório novamente:

    sudo apt-get update

Instala docker:

    sudo apt-get install docker-ce docker-ce-cli containerd.io

Adiciona seu usuário no grupo de permissões do docker:

    sudo usermod -aG docker $USER

### Instalação do docker-compose

Execute os seguintes comandos em seu terminal:

    sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    sudo chmod +x /usr/local/bin/docker-compose

Caso tenha algum problema para instalar, consulte documentação em: https://docs.docker.com/compose/install/


## Comandos de utilidade para acessar container

Essa sessão irá adicionar comandos ao seu bash que irão ajudar durante o seu trabalho

    curl -L "https://raw.githubusercontent.com/nielsonsantana/django-docker-compose-base-project/main/extra/bash-utils.sh" -o /home/$USER/bash-utils.sh
    echo -e "\nsource ./bash-utils.sh" >> ~/.bashrc
    source ~/.bashrc

Os comandos que serão adicionados:

    dc - alternativa ao docker-compose
    dockerenter - acessa container docker /bin/bash
    dockerentersh - acessa container docker com /bin/sh
    dcleanup - apaga imagens docker
    pyclean - apaga arquivos *.pyc do python no diretório


## Iniciar projeto em django

### Construir imagem do docker para o django

    docker-compose build

ou com atalho

    dc build

### Criar projeto em django

    docker-compose run web django-admin startproject nomedoseuprojeto .

Execute esse comando para tornar os arquivos criados dentro do container

    sudo chown $USER:$USER -R .

### Comunicação com o Banco Postgres

No arquivo `settings.py`, altere a seção `# Database` e substitua por:

    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql',
            'NAME': 'postgres',
            'USER': 'postgres',
            'PASSWORD': 'postgres',
            'HOST': 'db',
            'PORT': 5432,
        }
    }


### Executar projeto em django pela primeira vez

Execute o comando abaixo:

    docker-compose up

Agora acesse o link http://localhost:8000

### Executando migração pela primeira vez

Acessa container que está rodando:

    dockerenter web

Executa o comando de migração no container:

    python manage.py migrate

