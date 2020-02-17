docker build -t padronlv/multi-client:latest -t padronlv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t padronlv/multi-server:latest -t padronlv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t padronlv/multi-worker:latest -t padronlv/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push padronlv/multi-client:latest
docker push padronlv/multi-server:latest
docker push padronlv/multi-worker:latest
docker push padronlv/multi-client:$SHA
docker push padronlv/multi-server:$SHA
docker push padronlv/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=padronlv/multi-server:$SHA
kubectl set image deployments/client-deployment client=padronlv/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=padronlv/multi-worker:$SHA