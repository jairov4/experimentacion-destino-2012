sites = 9;
site = {
    {'NIb_CP' '2_9'}
    {'CI_6K2' '5_5'}
    {'6K2_VPg' '9_0'}
    {'VPg_NIa', '3_7'};
    {'P1_HC', '3_8'};
    {'NIa_NIb', '1_10'};
    {'P3_6K1', '2_8'};
    {'6K1_CI', '7_2'};
    {'HC_P3', '6_5'}
};
all_results = {};
for item=1:sites,
    filebasename = strcat(site{item}{1}, '_', site{item}{2});
    dir = '../CleavageSitesSampled/';
    csv_train_filename = strcat(dir, filebasename, '_train_balanced.csv');
    csv_test_filename = strcat(dir, filebasename, '_test.csv');
    train_data = importdata(csv_train_filename);
    fprintf('Cargado %s\n', csv_train_filename);
    test_data = importdata(csv_test_filename);    
    fprintf('Cargado %s\n', csv_test_filename);
    
    train_inputs = train_data(:,2:end);
    train_targets = train_data(:,1);
    test_inputs = test_data(:,2:end);
    test_targets = test_data(:,1);
    
     % entrena varios modelos
    hiddenLayerSize = 15;    
    model_count = 15;
    models = cell(model_count, 1);
    results = zeros(length(test_data), model_count+1);
    for model_index=1:model_count,        
        % nueva red para reconocimiento de patrones
        net = patternnet(hiddenLayerSize);
        net.divideParam.trainRatio = 90/100;
        net.divideParam.valRatio = 10/100;
        net.divideParam.testRatio = 0/100;
        % entrena un modelo
        [net, tr] = train(net, train_inputs', train_targets');        
        test_outputs = sim(net, test_inputs') > 0.5; % comprueba las decisiones por cada muestra
        % guarda el modelo y los resultados
        models{model_index}.net = net;
        models{model_index}.training = tr;
        models{model_index}.outputs = test_outputs';
        results(:,model_index) = test_outputs'; % resultados de un modelo en cada columna
        fprintf('Entrenado modelo %d\n', model_index);
    end;
    results(:,model_count+1) = test_targets; % targets en la ultima columna
    
    tp = 0;
    tn = 0;
    totalp = 0;
    totaln = 0;
    for I=1:length(test_data),
        row = results(I,:);
        cl = row(end); % clase
        vt = row(1:end-1); % votos
        vtv = sum(vt); % votacion
        clp = vtv > floor(model_count / 2); % clase por votacion
        if cl,
            totalp = totalp + 1;
        else
            totaln = totaln + 1;
        end
        if clp == cl,
           if cl == 0
               tn = tn + 1;
           end
           if cl == 1
               tp = tp + 1;
           end
        end;
    end;
    total = totalp+totaln;
    acc = (tp+tn)/total;
    spec = tn/totaln;
    sens = tp/totalp;
    % de los efectivamente negativos (totaln), 
    % resto los que acertadamente clasifico negativos (tn).
    % me quedan los que efectivamente eran negativos 
    % pero que equivocadametne clasifique como positivos (fp)
    fp = totaln-tn; 
    fn = totalp-tp;
    mcc = (tp*tn-fp*fn)/sqrt((tp+fp)*(tp+fn)*(tn+fp)*(tn+fn));    
    site{item} = struct('tp', tp, 'tn', tn, 'totalp', totalp, 'totaln', totaln, 'acc', acc, 'sens', sens, 'spec', spec, 'mcc', mcc, 'models', models);
    fprintf('Acc: %0.3f Spec: %0.3f Sens: %0.3f MCC: %0.3f\n', acc, spec, sens, mcc);
end;

