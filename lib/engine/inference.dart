import 'dart:developer';
import 'package:qualplaca/models/gpu_model.dart';

class InferenceEngine {
  List<GPU> gpuList = [];

  InferenceEngine() {
    gpuList = [
      GPU(
        name: 'NVIDIA GeForce RTX 3060',
        brand: 'NVIDIA',
        vram: 8,
        price: 800,
        clock: 2000,
        energy: 120,
        memoryInterface: 256,
        tags: ['Jogos', 'Trabalho'],
        urlImage:
            "https://www.nvidia.com/content/dam/en-zz/Solutions/about-nvidia/logo-and-brand/01-nvidia-logo-vert-500x200-2c50-d.png",
      ),
      GPU(
        name: 'AMD Radeon RX 5700 XT',
        brand: 'AMD',
        vram: 12,
        price: 453,
        clock: 1879,
        energy: 125,
        memoryInterface: 192,
        tags: ['Jogos'],
        urlImage: "https://cdn-icons-png.flaticon.com/512/731/731984.png",
      ),
      GPU(
        name: 'NVIDIA GeForce GTX 1660 Ti',
        brand: 'NVIDIA',
        vram: 6,
        price: 500,
        clock: 1200,
        energy: 125,
        memoryInterface: 192,
        tags: ['Jogos', 'Trabalho'],
        urlImage:
            "https://www.nvidia.com/content/dam/en-zz/Solutions/about-nvidia/logo-and-brand/01-nvidia-logo-vert-500x200-2c50-d.png",
      ),
      GPU(
        name: 'AMD Radeon RX 5600 XT',
        brand: 'AMD',
        vram: 4,
        price: 1200,
        clock: 5600,
        energy: 120,
        memoryInterface: 256,
        tags: ['Tô podendo'],
        urlImage: "https://cdn-icons-png.flaticon.com/512/731/731984.png",
      ),
      GPU(
        name: 'NVIDIA GeForce RTX 3070',
        brand: 'NVIDIA',
        vram: 16,
        price: 800,
        clock: 1922,
        energy: 125,
        memoryInterface: 192,
        tags: ['Jogos', 'Trabalho', 'Mineração'],
        urlImage:
            "https://www.nvidia.com/content/dam/en-zz/Solutions/about-nvidia/logo-and-brand/01-nvidia-logo-vert-500x200-2c50-d.png",
      ),
      GPU(
        name: 'AMD Radeon RX 6700 XT',
        brand: 'AMD',
        vram: 12,
        price: 468,
        clock: 1900,
        energy: 120,
        memoryInterface: 192,
        tags: ['Jogos', 'Trabalho', 'Mineração'],
        urlImage: "https://cdn-icons-png.flaticon.com/512/731/731984.png",
      ),
      GPU(
        name: 'NVIDIA GeForce GTX 1050 Ti',
        brand: 'NVIDIA',
        vram: 4,
        price: 300,
        clock: 1670,
        energy: 120,
        memoryInterface: 256,
        tags: ['Jogos', 'Trabalho'],
        urlImage:
            "https://www.nvidia.com/content/dam/en-zz/Solutions/about-nvidia/logo-and-brand/01-nvidia-logo-vert-500x200-2c50-d.png",
      ),
      GPU(
        name: 'AMD Radeon RX 5500 XT',
        brand: 'AMD',
        vram: 8,
        price: 760,
        clock: 2000,
        energy: 120,
        memoryInterface: 256,
        tags: ['Jogos', 'Trabalho'],
        urlImage: "https://cdn-icons-png.flaticon.com/512/731/731984.png",
      ),
      GPU(
        name: 'NVIDIA GeForce GTX 1660 Super',
        brand: 'NVIDIA',
        vram: 8,
        price: 350,
        clock: 1500,
        energy: 120,
        memoryInterface: 256,
        tags: ['Jogos'],
        urlImage:
            "https://www.nvidia.com/content/dam/en-zz/Solutions/about-nvidia/logo-and-brand/01-nvidia-logo-vert-500x200-2c50-d.png",
      ),
      GPU(
        name: 'AMD Radeon RX 6800 XT',
        brand: 'AMD',
        vram: 16,
        price: 800,
        clock: 2000,
        energy: 125,
        memoryInterface: 192,
        tags: ['Tô podendo', 'Mineração'],
        urlImage: "https://cdn-icons-png.flaticon.com/512/731/731984.png",
      ),
    ];
  }

  Map<String, dynamic> inference({
    bool preferBrand = false,
    required double budget,
    required int vram,
    required List<String> tags,
    String brand = "",
  }) {
    // filtro por orçamento
    List<GPU> recommendedGPUs =
        gpuList.where((gpu) => gpu.price <= budget).toList();

    // filtro por nome de marca
    if (preferBrand) {
      recommendedGPUs = recommendedGPUs
          .where(
              (gpu) => (gpu.brand.toLowerCase().contains(brand.toLowerCase())))
          .toList();
    }

    // filtro por tags
    recommendedGPUs = recommendedGPUs.where((gpu) {
      for (String tag in tags) {
        if (gpu.tags.contains(tag)) {
          return true;
        }
      }

      return false;
    }).toList();

    // filtro por quantidade de vram
    recommendedGPUs =
        recommendedGPUs.where((gpu) => (gpu.vram <= vram)).toList();

    GPU bestChoice = recommendedGPUs.first;
    int maxRam = bestChoice.vram;
    double maxClock = bestChoice.clock;
    int maxInterfaceMemory = bestChoice.memoryInterface;
    double minEnergy = bestChoice.energy;
    double minPrice = bestChoice.price;

    for (var gpu in recommendedGPUs) {
      log("Nome: ${gpu.name}");

      if (gpu.price < minPrice) {
        log("MELHOR EM PREÇO");
        if (gpu.vram >= maxRam) {
          log("MELHOR EM RAM");
          if (gpu.clock >= maxClock) {
            log("MELHOR EM CLOCK");
            if (gpu.memoryInterface >= maxInterfaceMemory) {
              log("MELHOR EM INTERFACEMEMORY");
              if (gpu.energy <= minEnergy) {
                log("MELHOR EM GASTO DE ENERGIA");
                maxRam = gpu.vram;
                maxClock = gpu.clock;
                maxInterfaceMemory = gpu.memoryInterface;
                minEnergy = gpu.energy;
                minPrice = gpu.price;
                bestChoice = gpu;
                log("MELHOR Nome: ${gpu.name}");
              }
            }
          }
        }
      }
    }

    recommendedGPUs.remove(bestChoice);

    return {
      "gpu": bestChoice,
      "recommendedGPUs": recommendedGPUs,
    };
  }
}
