cd cyber-carpentry-group2-machine-learning-*

rule all:
        output: "results/mnist_model_results_summary.txt", "results/fashion_model_results_summary.txt"

rule fashion:
        input: "data/fashion.txt"
        output: "results/fashion_model_results_summary.txt"
        shell: '''python run_main.py {input} -o results'''

rule mnist:
        input: "data/mnist.txt"
        output: "results/mnist_model_results_summary.txt"
        shell: '''python run_main.py {input} -o results'''